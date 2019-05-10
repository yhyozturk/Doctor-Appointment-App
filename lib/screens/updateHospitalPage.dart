import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/dbHelper/updateData.dart';
import 'package:fast_turtle_v2/models/hospitalModel.dart';
import 'package:fast_turtle_v2/screens/showHospitals.dart';
import 'package:flutter/material.dart';
import 'package:fast_turtle_v2/mixins/validation_mixin.dart';

class UpdateHospital extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UpdateHospitalState();
  }
}

class UpdateHospitalState extends State with ValidationMixin {
  Hospital hastane = Hospital();
  bool hastaneSecildiMi = false;
  double goruntu = 0.0;
  String newName;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(
          "Hastane Güncelle Ekranı",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 18.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Hastane Seçmek İçin Tıkla"),
                      onPressed: () {
                        hospitalNavigator(BuildHospitalList());
                      },
                    ),
                    SizedBox(height: 13.0),
                    showSelectedHospital(hastaneSecildiMi),
                    SizedBox(
                      height: 30.0,
                    ),
                    _yeniHastaneAdi(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _guncelleButonu()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _yeniHastaneAdi() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Yeni Hastane Adini Girin:",
          labelStyle: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Colors.black)),
      validator: validateFirstName,
      onSaved: (String value) {
        newName = value;
      },
    );
  }

  void hospitalNavigator(dynamic page) async {
    hastane = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));

    if (hastane == null) {
      hastaneSecildiMi = false;
    } else {
      hastaneSecildiMi = true;
    }
  }

  showSelectedHospital(bool secildiMi) {
    String textMessage = " ";
    if (secildiMi) {
      setState(() {
        textMessage = this.hastane.hastaneAdi.toString();
      });
      goruntu = 1.0;
    } else {
      goruntu = 0.0;
    }

    return Container(
        decoration: BoxDecoration(),
        child: Row(
          children: <Widget>[
            Text(
              "Seçilen Hastane : ",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Opacity(
                opacity: goruntu,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    textMessage,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ));
  }

  void alrtHospital(BuildContext context, String message) {
    var alertDoctor = AlertDialog(
      title: Text(
        "Uyarı!",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(message),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDoctor;
        });
  }

  _guncelleButonu() {
    return Container(
      child: RaisedButton(
        child: Text(
          "Hastaneyi Güncelle",
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            SearchService()
                .searchHospitalByName(newName)
                .then((QuerySnapshot docs) {
              if (docs.documents.isEmpty && newName != hastane.hastaneAdi) {
                hastane.hastaneAdi = newName;
                UpdateService().updateHastane(hastane);
                Navigator.pop(context, true);
              } else {
                alrtHospital(context, "Bu isimde bir hastane zaten mevcut");
              }
            });
          } else {
            alrtHospital(context, "Eksik bilgi");
          }
        },
      ),
    );
  }
}
