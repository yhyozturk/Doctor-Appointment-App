import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:flutter/material.dart';

class OpenCloseAppointment extends StatefulWidget {
  @override
  OpenCloseAppointmentState createState() => OpenCloseAppointmentState();
}

class OpenCloseAppointmentState extends State<OpenCloseAppointment> {
  var hospitalNames = [];
  var sectionNames = [];
  var doctorNames = [];
  Doktor doktor;
  var selectedHospital;
  var selectedSection;
  var selectedDoctor;

  @override
  void initState() {
    super.initState();
    initiateHospitals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(
          "Admin Randevu Aç/Kapa",
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
                  Container(
                      padding: EdgeInsets.only(left: 20.0, top: 25.0),
                      child: Column(
                        children: <Widget>[
                          chooserHospital(),
                          chooserSection(),
                          chooserDoctor(),
                          chooserDate(),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(20),
                            color: Colors.amberAccent,
                            child: chooserTime(),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
        child: _cikisYapButonu(),
      ),
    );
  }

  initiateHospitals() {
    SearchService().getHospitals().then((QuerySnapshot docs) {
      for (var i = 0; i < docs.documents.length; i++) {
        hospitalNames.add(docs.documents[i]['hastaneAdi'].toString());
      }
    });
  }

  getSections(int hastaneId) {
    SearchService().getSections().then((QuerySnapshot docs) {
      for (var i = 0; i < docs.documents.length; i++) {
        if (docs.documents[i]['hastaneId'] == hastaneId) {
          sectionNames.add(docs.documents[i]['bolumAdi'].toString());
        }
      }
    });
  }

  getDoctors(int hastaneId, int bolumId) {
    SearchService().getDoctors().then((QuerySnapshot docs) {
      for (var i = 0; i < docs.documents.length; i++) {
        if (docs.documents[i]['hastaneId'] == hastaneId && docs.documents[i]['bolumId'] == bolumId) {
          sectionNames.add(docs.documents[i]['ad'].toString());
        }
      }
    });
  }

  chooserSection() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 25.0),
          child: Text(
            "Bölümü Seçin: ",
            style: TextStyle(fontSize: 19.0),
          ),
        ),
        DropdownButton<String>(
          hint: Text("Bölüm Seçin"),
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

              //getDoctors();
            });
          },
        ),
      ],
    );
  }

  chooserDoctor() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 25.0),
          child: Text(
            "Doktor Seçin: ",
            style: TextStyle(fontSize: 19.0),
          ),
        ),
        DropdownButton<String>(
          hint: Text("Doktor Seçin"),
          items: doctorNames.map((doctors) {
            return DropdownMenuItem<String>(
              value: doctors,
              child: Text(doctors),
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
    );
  }

  chooserHospital() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 25.0),
          child: Text(
            "Hastane Seçin: ",
            style: TextStyle(fontSize: 19.0),
          ),
        ),
        DropdownButton<String>(
          hint: Text("Hastane Seçin"),
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

              //getSections();
            });
          },
        ),
      ],
    );
  }

  chooserDate() {
    return Container(
      padding: EdgeInsets.only(right: 25.0),
      child: Row(
        children: <Widget>[
          Text(
            "Tarih Seçin ",
            style: TextStyle(fontSize: 19.0),
          ),
          RaisedButton(
            child: Text("Tarih Seçin"),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  chooserTime() {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "09.00 ",
                style: TextStyle(fontSize: 19.0),
              ),
              RaisedButton(
                child: Text(
                  "Aç/Kapat",
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {},
              ),
              Text(
                "10.00 ",
                style: TextStyle(fontSize: 19.0),
              ),
              RaisedButton(
                child: Text(
                  "Aç/Kapat",
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "11.00 ",
                style: TextStyle(fontSize: 19.0),
              ),
              RaisedButton(
                child: Text(
                  "Aç/Kapat",
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {},
              ),
              Text(
                "12.00 ",
                style: TextStyle(fontSize: 19.0),
              ),
              RaisedButton(
                child: Text(
                  "Aç/Kapat",
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "13.00 ",
                style: TextStyle(fontSize: 19.0),
              ),
              RaisedButton(
                child: Text(
                  "Aç/Kapat",
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {},
              ),
              Text(
                "14.00 ",
                style: TextStyle(fontSize: 19.0),
              ),
              RaisedButton(
                child: Text(
                  "Aç/Kapat",
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "15.00 ",
                style: TextStyle(fontSize: 19.0),
              ),
              RaisedButton(
                child: Text(
                  "Aç/Kapat",
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {},
              ),
              Text(
                "16.00 ",
                style: TextStyle(fontSize: 19.0),
              ),
              RaisedButton(
                child: Text(
                  "Aç/Kapat",
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ],
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
