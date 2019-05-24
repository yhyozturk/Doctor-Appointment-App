import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:fast_turtle_v2/models/hospitalModel.dart';
import 'package:fast_turtle_v2/models/sectionModel.dart';
import 'package:fast_turtle_v2/screens/showAppoForDoc.dart';
import 'package:fast_turtle_v2/screens/updateDoctorPass.dart';
import 'package:flutter/material.dart';

class DoctorHomePage extends StatefulWidget {
  final Doktor doktor;
  DoctorHomePage(this.doktor);
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState(doktor);
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  Doktor _doktor;
  _DoctorHomePageState(this._doktor);

  Hospital hastane;
  Section bolum;
  @override
  void initState() {
    super.initState();
    SearchService()
        .searchHospitalById(_doktor.hastaneId)
        .then((QuerySnapshot docs) {
      this.hastane = Hospital.fromMap(docs.documents[0].data);
    });
    SearchService()
        .searchSectionById(_doktor.bolumId)
        .then((QuerySnapshot docs) {
      this.bolum = Section.fromMap(docs.documents[0].data);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String hastaneAdi, bolumAdi;
    setState(() {
      hastaneAdi = hastane.hastaneAdi.toString();
      bolumAdi = bolum.bolumAdi;
    });
    return Scaffold(
        appBar: AppBar(
          title: Text("Doktor Ana Sayfası"),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(top: 30.0, left: 5.0, right: 5.0, bottom: 25.0),
            color: Colors.blueAccent[200],
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18.0),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 13.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 18.0),
                        child: Icon(
                          Icons.healing,
                          size: 50.0,
                        ),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Container(
                        child: Text(
                          _doktor.adi,
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        child: Text(
                          _doktor.soyadi,
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Container(
                    color: Colors.grey,
                    width: 370.0,
                    height: 0.4,
                  ),
                  _buildAttributeRow("T.C. Kimlik Numarası", _doktor.kimlikNo),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, left: 13.0),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.greenAccent,
                          width: 120.0,
                          height: 25.0,
                          child: Text(
                            "Hastane",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, left: 13.0),
                        child: Container(
                          child: Text(
                            hastaneAdi,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                  _buildAttributeRow("Bölüm ", bolumAdi.toString()),
                  SizedBox(
                    height: 30.0,
                  )
                ],
              ),
            ),
          ),
          Container(
            width: screenSize.width,
            height: screenSize.height / 2,
            color: Colors.blueAccent[200],
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                _sifreGuncelleButonu(),
                SizedBox(
                  height: 7.0,
                ),
                _randevulariGotuntuleButonu(),
                SizedBox(
                  height: 7.0,
                ),
                _cikisYapButonu(),
              ],
            ),
          )
        ])));
  }

  Widget _buildAttributeRow(var textMessage, var textValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0, left: 13.0),
          child: Container(
            alignment: Alignment.center,
            color: Colors.greenAccent,
            width: 200.0,
            height: 25.0,
            child: Text(
              textMessage,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          width: 25.0,
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0, left: 13.0),
          child: Container(
            child: Text(
              textValue,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  _sifreGuncelleButonu() {
    return Container(
      padding: EdgeInsets.all(1.0),
      width: 390.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white),
      child: FlatButton(
        splashColor: Colors.grey,
        highlightColor: Colors.white70,
        child: Text(
          "Şifre Güncelle",
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          basicNavigator(OnlyUpdatePassword(_doktor), "İşlem Tamamlandı");
        },
      ),
    );
  }

  _randevulariGotuntuleButonu() {
    return Container(
      padding: EdgeInsets.all(1.0),
      width: 390.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white),
      child: FlatButton(
        splashColor: Colors.grey,
        highlightColor: Colors.white70,
        child: Text(
          "Randevuları Görüntüle",
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BuildAppointmentListForDoctor(_doktor)));
        },
      ),
    );
  }

  void basicNavigator(dynamic page, String message) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));

    if (result != null && result == true) {
      alrtHospital(context, message);
    }
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
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
