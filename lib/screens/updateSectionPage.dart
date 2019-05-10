import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/dbHelper/updateData.dart';
import 'package:fast_turtle_v2/models/hospitalModel.dart';
import 'package:fast_turtle_v2/models/sectionModel.dart';
import 'package:fast_turtle_v2/screens/showHospitals.dart';
import 'package:fast_turtle_v2/screens/showSections.dart';
import 'package:flutter/material.dart';

class UpdateSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UpdateSectionState();
  }
}

class UpdateSectionState extends State {
  Hospital hastane = Hospital();
  double goruntu = 0.0;
  bool hastaneSecildiMi = false;
  bool bolumSecildiMi = false;
  Section section = Section();
  String textMessage = " ";
  String yeniBolumAdi;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(
          "Bölüm Güncelle Ekranı",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 50.0, left: 15.0, right: 20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: RaisedButton(
                        child: Text(
                          "Hastane Seçmek İçin Tıkla",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          bolumSecildiMi = false;
                          hospitalNavigator(BuildHospitalList());
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    showSelectedHospital(hastaneSecildiMi),
                    SizedBox(
                      height: 30.0,
                    ),
                    RaisedButton(
                      child: Text("Bölüm Seçmek İçin Tıkla"),
                      onPressed: () {
                        if (hastaneSecildiMi) {
                          sectionNavigator(BuildSectionList(hastane));
                        } else {
                          alrtHospital(
                              context, "Hastane seçmeden bölüm seçemezsiniz");
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    _showSelectedSection(bolumSecildiMi),
                    SizedBox(
                      height: 30.0,
                    ),
                    _yeniBolumAdi(),
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

  _yeniBolumAdi() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Yeni Bölüm Adini Girin:",
          labelStyle: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Colors.black)),
      onSaved: (String value) {
        yeniBolumAdi = value;
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

  void sectionNavigator(dynamic page) async {
    section = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));

    if (section == null) {
      bolumSecildiMi = false;
    } else {
      bolumSecildiMi = true;
    }
  }

  void alrtHospital(BuildContext context, String message) {
    var alertHospital = AlertDialog(
      title: Text("Uyarı!"),
      content: Text(message),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertHospital;
        });
  }

  _showSelectedSection(bool secildiMi) {
    double goruntu = 0.0;

    if (secildiMi) {
      setState(() {
        textMessage = this.section.bolumAdi.toString();
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
              "Seçilen Bölüm : ",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Opacity(
                opacity: goruntu,
                child: Container(
                    alignment: Alignment.center,
                    child: _buildTextMessage(textMessage)))
          ],
        ));
  }

  _buildTextMessage(String gelenText) {
    return Text(
      textMessage,
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    );
  }

  _guncelleButonu() {
    return RaisedButton(
      child: Text(
        "Bölümü Güncelle",
        textDirection: TextDirection.ltr,
        style: TextStyle(fontSize: 20.0),
      ),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          SearchService()
              .searchSectionByHospitalIdAndSectionName(
                  hastane.hastaneId, yeniBolumAdi)
              .then((QuerySnapshot docs) {
            if (docs.documents.isEmpty && section.bolumAdi != yeniBolumAdi) {
              section.bolumAdi = yeniBolumAdi;
              UpdateService().updateSection(section);
              Navigator.pop(context, true);
            } else {
              alrtHospital(context,
                  "Seçtiğiniz hastanede aynı isimde bir bölüm zaten mevcut");
            }
          });
        } else {
          alrtHospital(context, "Eksik Bilgi");
        }
      },
    );
  }
}
