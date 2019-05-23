import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/addData.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/models/adminModel.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:fast_turtle_v2/models/hospitalModel.dart';
import 'package:fast_turtle_v2/models/sectionModel.dart';
import 'package:fast_turtle_v2/models/userModel.dart';
import 'package:fast_turtle_v2/screens/showAppointmentTimes.dart';
import 'package:fast_turtle_v2/screens/showHospitals.dart';
import 'package:fast_turtle_v2/screens/showSections.dart';
import 'package:flutter/material.dart';

import 'showDoctors.dart';

class CloseAppointment extends StatefulWidget {
  final Admin admin;
  CloseAppointment(this.admin);
  @override
  CloseAppointmentState createState() => CloseAppointmentState(admin);
}

class CloseAppointmentState extends State<CloseAppointment> {
  Admin _admin;
  CloseAppointmentState(this._admin);
  bool hastaneSecildiMi = false;
  bool bolumSecildiMi = false;
  bool doktorSecildiMi = false;
  bool tarihSecildiMi = false;
  bool appointmentControl1;
  bool appointmentControl2;

  double drGoruntu = 0.0;
  double goruntu = 0.0;

  Hospital hastane = Hospital();
  Section section = Section();
  Doktor doktor = Doktor();
  User kullanici = User();

  String textMessage = " ";

  var randevuTarihi;
  var raisedButtonText = "Tıkla ve Seç";

  var saatTarihBirlesim;

  double goruntuSaat = 0.0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      Firestore.instance
          .collection('tblAdmin')
          .getDocuments()
          .then((QuerySnapshot docs) {
        _admin.reference = docs.documents[0].reference;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Doktor Randevusu Kapat",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0, left: 9.0, right: 9.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text("Hastane Seçmek İçin Tıkla"),
                    onPressed: () {
                      bolumSecildiMi = false;
                      doktorSecildiMi = false;
                      tarihSecildiMi = false;
                      hospitalNavigator(BuildHospitalList());
                    },
                  ),
                  SizedBox(height: 13.0),
                  showSelectedHospital(hastaneSecildiMi),
                  SizedBox(
                    height: 30.0,
                  ),
                  RaisedButton(
                    child: Text("Bölüm Seçmek İçin Tıkla"),
                    onPressed: () {
                      if (hastaneSecildiMi) {
                        doktorSecildiMi = false;
                        drGoruntu = 0.0;
                        tarihSecildiMi = false;
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
                  RaisedButton(
                    child: Text("Doktor Seçmek İçin Tıkla"),
                    onPressed: () {
                      if (hastaneSecildiMi && bolumSecildiMi) {
                        doctorNavigator(BuildDoctorList(section, hastane));
                      } else {
                        alrtHospital(context,
                            "Hastane ve bölüm seçmeden doktor seçemezsiniz");
                      }
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  showSelectedDoctor(doktorSecildiMi),
                  SizedBox(
                    height: 25.0,
                  ),
                  dateOfAppointment(),
                  SizedBox(
                    height: 16.0,
                  ),
                  RaisedButton(
                    child: Text("İşlem Saati Seçmek İçin Tıkla"),
                    onPressed: () {
                      if (randevuTarihi != null &&
                          hastaneSecildiMi &&
                          bolumSecildiMi &&
                          doktorSecildiMi) {
                        basicNavigator(
                            AppointmentTimes(randevuTarihi.toString(), doktor));
                        tarihSecildiMi = true;
                      } else {
                        alrtHospital(context,
                            "Yukarıdaki seçimler tamamlanmadan saat seçimine geçilemez");
                      }
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  showSelectedDate(tarihSecildiMi),
                  SizedBox(
                    height: 16.0,
                  ),
                  _buildDoneButton()
                ],
              ),
            ),
          )
        ],
      ),
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

  void sectionNavigator(dynamic page) async {
    section = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));

    if (section == null) {
      bolumSecildiMi = false;
    } else {
      bolumSecildiMi = true;
    }
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

  void doctorNavigator(dynamic page) async {
    doktor = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));

    if (doktor == null) {
      doktorSecildiMi = false;
    } else {
      doktorSecildiMi = true;
    }
  }

  showSelectedDoctor(bool secildiMih) {
    String textMessage = " ";
    if (secildiMih) {
      setState(() {
        textMessage = this.doktor.adi.toString() + " " + this.doktor.soyadi;
      });
      drGoruntu = 1.0;
    } else {
      drGoruntu = 0.0;
    }

    return Container(
        decoration: BoxDecoration(),
        child: Row(
          children: <Widget>[
            Text(
              "Seçilen Doktor : ",
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2021),
    );
    randevuTarihi = picked;
    saatTarihBirlesim = null;
    tarihSecildiMi = false;
  }

  Widget dateOfAppointment() {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child: Row(
        children: <Widget>[
          Text(
            "İşlem Tarihi: ",
            style: TextStyle(fontSize: 19.0),
          ),
          RaisedButton(
            child: Text(raisedButtonText),
            onPressed: () {
              _selectDate(context).then((result) => setState(() {
                    if (randevuTarihi == null) {
                      raisedButtonText = "Tıkla ve Seç";
                      tarihSecildiMi = false;
                    } else {
                      raisedButtonText =
                          randevuTarihi.toString().substring(0, 10);
                    }
                  }));
            },
          )
        ],
      ),
    );
  }

  showSelectedDate(bool tarihSecildiMi) {
    String textMessage = " ";
    if (tarihSecildiMi) {
      setState(() {
        textMessage = saatTarihBirlesim.toString();
      });
      goruntuSaat = 1.0;
    } else {
      goruntuSaat = 0.0;
    }

    return Container(
        decoration: BoxDecoration(),
        child: Row(
          children: <Widget>[
            Text(
              "İşlem Tarih ve Saati : ",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Opacity(
                opacity: goruntuSaat,
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

  void basicNavigator(dynamic page) async {
    saatTarihBirlesim = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  void alrtAppointment(BuildContext context) {
    var alertAppointment = AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(5.0, 50.0, 5.0, 50.0),
        title: Text(
          "İşlem Özeti",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Container(
          padding: EdgeInsets.only(bottom: 50.0),
          child: Column(
            children: <Widget>[
              showSelectedHospital(hastaneSecildiMi),
              _showSelectedSection(bolumSecildiMi),
              showSelectedDoctor(doktorSecildiMi),
              showSelectedDate(tarihSecildiMi),
              SizedBox(
                height: 13.0,
              ),
              Container(
                child: FlatButton(
                  child: Text(
                    "Tamam",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context, true);
                    AddService().addDoctorAppointment(doktor);
                    AddService().closeDoctorAppointment(_admin);
                  },
                ),
              ),
            ],
          ),
        ));

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertAppointment;
        });
  }

  _buildDoneButton() {
    return Container(
      child: RaisedButton(
        child: Text("Tamamla"),
        onPressed: () {
          if (hastaneSecildiMi &&
              bolumSecildiMi &&
              doktorSecildiMi &&
              tarihSecildiMi &&
              saatTarihBirlesim != null) {
            SearchService()
                .searchDoctorAppointment(doktor, saatTarihBirlesim)
                .then((QuerySnapshot docs) {
              if (docs.documents.isEmpty) {
                alrtAppointment(context);
                doktor.randevular.add(saatTarihBirlesim);
                _admin.kapatilanSaatler.add(saatTarihBirlesim);
              } else {
                alrtHospital(context, "Bu seans dolu");
              }
            });
          } else {
            alrtHospital(context, "Eksik bilgi var");
          }
        },
      ),
    );
  }
}
