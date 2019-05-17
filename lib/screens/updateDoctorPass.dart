import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/dbHelper/updateData.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:flutter/material.dart';

class OnlyUpdatePassword extends StatefulWidget {
  final Doktor doktor;
  OnlyUpdatePassword(this.doktor);
  @override
  _OnlyUpdatePasswordState createState() => _OnlyUpdatePasswordState(doktor);
}

class _OnlyUpdatePasswordState extends State<OnlyUpdatePassword> {
  Doktor doktor;
  _OnlyUpdatePasswordState(this.doktor);
  final formKey = GlobalKey<FormState>();
  String yeniSifre;
  String eskiSifre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Şifre Güncelle"),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    eskiSifreField(),
                    SizedBox(
                      height: 13.0,
                    ),
                    sifreField(),
                    SizedBox(
                      height: 45.0,
                    ),
                    submitButton()
                  ],
                ),
              )),
        ));
  }

  Widget sifreField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Yeni Şifre",
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      onSaved: (String value) {
        yeniSifre = value;
      },
      obscureText: true,
    );
  }

  Widget eskiSifreField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Eski Şifre",
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      onSaved: (String value) {
        eskiSifre = value;
      },
      obscureText: true,
    );
  }

  submitButton() {
    return Container(
      child: RaisedButton(
        child: Text("Tamamla"),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            if (doktor.sifre != yeniSifre && doktor.sifre == eskiSifre) {
              doktor.sifre = yeniSifre;
              SearchService()
                  .searchDoctorById(doktor.kimlikNo)
                  .then((QuerySnapshot docs) {
                doktor.reference = docs.documents[0].reference;
                UpdateService().updateDoktor(doktor);
              });

              Navigator.pop(context, true);
            } else {
              alrtHospital(context, "Hatalı yada eksik bilgi girdiniz...");
            }
          } else {
            alrtHospital(context, "Hatalı yada eksik bilgi girdiniz...");
          }
        },
      ),
    );
  }

  void alrtHospital(BuildContext context, String message) {
    var alertDoctor = AlertDialog(
      title: Text(
        "Bilgilendirme!",
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
}
