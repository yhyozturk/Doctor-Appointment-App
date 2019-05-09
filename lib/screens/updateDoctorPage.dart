import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:flutter/material.dart';

class UpdateDoctor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UpdateDoctorState();
  }
}

class UpdateDoctorState extends State {
  var doctorNames = [];
  var selectedDoctor;
  var sectionNames = [];
  var hospitalNames = [];
  var selectedHospital;
  var selectedSection;

  @override
  void initState() {
    super.initState();
    initiateDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: Text(
            "Doktor Güncelle Ekranı",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(50.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      _hastaneSecField(),
                      _bolumSecField(),
                      _doktorSecField(),
                      _yeniDoktorAdi(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _guncelleButonu()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
        child: _cikisYapButonu(),
      ),);
  }

  initiateDoctors() {
    SearchService().getDoctors().then((QuerySnapshot docs) {
      for (var i = 0; i < docs.documents.length; i++) {
        doctorNames.add(docs.documents[i]['ad'].toString());
      }
    });
  }

  initiateHospitals() {
    SearchService().getHospitals().then((QuerySnapshot docs) {
      for (var i = 0; i < docs.documents.length; i++) {
        hospitalNames.add(docs.documents[i]['hastaneAdi'].toString());
      }
    });
  }

  _hastaneSecField() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 25.0),
            child: Text(
              "Hastane: ",
              style: TextStyle(fontSize: 19.0),
            ),
          ),
          DropdownButton<String>(
            hint: Text("Lütfen Seçiniz"),
            items: hospitalNames.map((hastaneler) {
              return DropdownMenuItem<String>(
                value: hastaneler,
                child: Text(hastaneler),
              );
            }).toList(),
            value: selectedHospital,
            onChanged: (String tiklanan) {
              setState(() {
                if (tiklanan == null) {
                  this.selectedHospital = hospitalNames[0];
                } else {
                  this.selectedHospital = tiklanan;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  initiateSections() {
    SearchService().getSections().then((QuerySnapshot docs) {
      for (var i = 0; i < docs.documents.length; i++) {
        sectionNames.add(docs.documents[i]['bolumAdi'].toString());
      }
    });
  }

  _bolumSecField() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 25.0),
            child: Text(
              "Bölüm: ",
              style: TextStyle(fontSize: 19.0),
            ),
          ),
          DropdownButton<String>(
            hint: Text("Lütfen Seçiniz"),
            items: sectionNames.map((bolumler) {
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
      ),
    );
  }

  _doktorSecField() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 25.0),
            child: Text(
              "Doktor: ",
              style: TextStyle(fontSize: 19.0),
            ),
          ),
          DropdownButton<String>(
            hint: Text("Lütfen Seçiniz"),
            items: doctorNames.map((doktorlar) {
              return DropdownMenuItem<String>(
                value: doktorlar,
                child: Text(doktorlar),
              );
            }).toList(),
            value: selectedDoctor,
            onChanged: (String tiklanan) {
              setState(() {
                if (tiklanan == null) {
                  this.selectedDoctor = doctorNames[0];
                } else {
                  this.selectedDoctor = tiklanan;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  _yeniDoktorAdi() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Yeni Doktor Adini Girin:",
          labelStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
      onSaved: (String value) {},
    );
  }

  _guncelleButonu() {
    return RaisedButton(
        child: Text(
          "Doktoru Güncelle",
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {},
      );
  }

  _cikisYapButonu() {
    return Container(
      padding: EdgeInsets.all(1.0),
      width: 390.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.redAccent),
      child: FlatButton(
        splashColor: Colors.grey,
        highlightColor: Colors.white70,
        child: Text(
          "Güvenli Çıkış",
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {},
      ),
    );
  }

}