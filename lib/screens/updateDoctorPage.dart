import 'package:fast_turtle_v2/dbHelper/updateData.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:fast_turtle_v2/models/hospitalModel.dart';
import 'package:fast_turtle_v2/models/sectionModel.dart';
import 'package:fast_turtle_v2/screens/showDoctors.dart';
import 'package:fast_turtle_v2/screens/showHospitals.dart';
import 'package:fast_turtle_v2/screens/showSections.dart';
import 'package:flutter/material.dart';
import 'package:fast_turtle_v2/mixins/validation_mixin.dart';

class UpdateDoctor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UpdateDoctorState();
  }
}

class UpdateDoctorState extends State with ValidationMixin {
  Hospital hastane = Hospital();
  Doktor doktor = Doktor();
  double goruntu = 0.0;
  double drGoruntu = 0.0;
  bool hastaneSecildiMi = false;
  bool bolumSecildiMi = false;
  bool doktorSecildiMi = false;
  Section section = Section();
  String textMessage = " ";
  String yeniAd, yeniSoyad, yeniSifre;
  final formKey = GlobalKey<FormState>();

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
              padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 13.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Adım 1 : Güncelleme yapılacak doktoru seçin",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    RaisedButton(
                      child: Text("Hastane Seçmek İçin Tıkla"),
                      onPressed: () {
                        bolumSecildiMi = false;
                        doktorSecildiMi = false;
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
                    Container(
                      height: 1.3,
                      width: 350.0,
                      color: Colors.green,
                    ),
                    Container(
                      child: Text(
                        "Adım 2 : Seçtiğiniz doktorun güncel bilgilerini girin",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    _yeniDoktorAdi(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _yeniDoktorSoyadi(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _yeniDoktorSifresi(),
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

  _yeniDoktorAdi() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Adı :",
          labelStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
      validator: validateFirstName,
      onSaved: (String value) {
        yeniAd = value;
      },
    );
  }

  _yeniDoktorSoyadi() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Soyadı :",
          labelStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
      validator: validateLastName,
      onSaved: (String value) {
        yeniSoyad = value;
      },
    );
  }

  _yeniDoktorSifresi() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Şifresi :",
          labelStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
      validator: validateLastName,
      onSaved: (String value) {
        yeniSifre = value;
      },
    );
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

  _guncelleButonu() {
    return RaisedButton(
      child: Text(
        "Doktoru Güncelle",
        textDirection: TextDirection.ltr,
        style: TextStyle(fontSize: 20.0),
      ),
      onPressed: () {
        if (hastaneSecildiMi && bolumSecildiMi && doktorSecildiMi) {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            doktor.adi = yeniAd;
            doktor.soyadi = yeniSoyad;
            doktor.sifre = yeniSifre;

            UpdateService().updateDoktor(doktor);
            Navigator.pop(context, true);
          }
        } else {
          alrtHospital(context, "Tamamlanmamış bilgiler var");
        }
      },
    );
  }
}
