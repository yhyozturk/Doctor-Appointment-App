import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:flutter/material.dart';
import 'package:fast_turtle_v2/mixins/validation_mixin.dart';

class AddDoctor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddDoctorState();
  }
}

class AddDoctorState extends State with ValidationMixin {
  List<String> hospitalNames = [];
  List<String> sectionNames = [];
  Doktor doktor;
  var selectedHospital;
  var selectedSection;
  int tempId;

  @override
  void initState() {
    super.initState();
    initiateHospitals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Doktor Ekle",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20.0, left: 9.0, right: 9.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      _kimlikNoField(),
                      _passwordField(),
                      _nameField(),
                      _surnameField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      chooserButton(),
                      SizedBox(
                        height: 10.0,
                      ),
                      choosSectionButton()
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _kimlikNoField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "T.C. Kimlik Numarası:",
          labelStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
      validator: validateTCNo,
      onSaved: (String value) {
        doktor.kimlikNo = value;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Şifre:",
          labelStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
      obscureText: true,
      onSaved: (String value) {
        doktor.sifre = value;
      },
    );
  }

  Widget _nameField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Ad:",
          labelStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
      validator: validateFirstName,
      onSaved: (String value) {
        doktor.adi = value;
      },
    );
  }

  Widget _surnameField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Soyad:",
          labelStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
      validator: validateLastName,
      onSaved: (String value) {
        doktor.soyadi = value;
      },
    );
  }

  initiateHospitals() {
    SearchService().getHospitals().then((QuerySnapshot docs) {
      for (var i = 0; i < docs.documents.length; i++) {
        hospitalNames.add(docs.documents[i]['hastaneAdi'].toString());
      }
    });
  }

  initiateSections() async {
    if (this.tempId != null) {
     await SearchService()
          .searchSectionsByHospitalId(this.tempId)
          .then((QuerySnapshot docs) {
        for (var i = 0; i < docs.documents.length; i++) {
          sectionNames.add(docs.documents[i]['bolumAdi'].toString());
        }
      });
    }
  }

  Widget chooserButton() {
    return Container(
        padding: EdgeInsets.only(top: 13.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 25.0),
              child: Text(
                "Hastaneler : ",
                style: TextStyle(fontSize: 19.0),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            DropdownButton<String>(
              hint: Text("Tıkla Seç"),
              items: hospitalNames.map((String hastaneler) {
                return DropdownMenuItem<String>(
                  value: hastaneler,
                  child: Text(hastaneler),
                );
              }).toList(),
              value: selectedHospital,
              onChanged: (String tiklanan) {
                setState(() {
                  SearchService()
                      .searchHospitalByName(selectedHospital)
                      .then((QuerySnapshot docs) {
                    tempId = docs.documents[0]['hastaneId'];
                  });
                  if (tiklanan == null) {
                    this.selectedHospital = hospitalNames[0];
                  } else {
                    this.selectedHospital = tiklanan;
                  }
                   initiateSections();
                });
              },
            ),
          ],
        ));
  }

  Widget choosSectionButton() {
    return Container(
        padding: EdgeInsets.only(top: 8.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 25.0),
              child: Text(
                "Bölümler     : ",
                style: TextStyle(fontSize: 19.0),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            DropdownButton<String>(
              hint: Text("Tıkla Seç"),
              items: sectionNames.map((String bolumler) {
                return DropdownMenuItem<String>(
                  value: bolumler,
                  child: Text(bolumler),
                );
              }).toList(),
              value: selectedSection,
              onChanged: (String tiklanan) {
                setState(() {
                  if (tiklanan == null) {
                    this.selectedSection = sectionNames[0];
                  } else {
                    this.selectedSection = tiklanan;
                  }
                });
              },
            ),
          ],
        ));
  }
}
