import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:flutter/material.dart';

class MakeAppointment extends StatefulWidget {
  @override
  MakeAppointmentState createState() => MakeAppointmentState();
}

class MakeAppointmentState extends State<MakeAppointment> {

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
      appBar: AppBar(
        title: Text(
          "Randevu Al",
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
                  chooserButton(),
                ],
              ),
            ),
          )
        ],
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

  

  getSections(String ad) {
    SearchService().getSections().then((QuerySnapshot docs) {
        for (var i = 0; i < docs.documents.length; i++) {
          if (docs.documents[i]['hastaneAdi']==ad) {
            sectionNames.add(docs.documents[i]['bolumAdi'].toString());
          }
      }
    });
  }
  getDoctors(String ad) {
    SearchService().getSections().then((QuerySnapshot docs) {
        for (var i = 0; i < docs.documents.length; i++) {
          if (docs.documents[i]['hastaneAdi']==ad) {
            sectionNames.add(docs.documents[i]['bolumAdi'].toString());
          }
      }
    });
  }
  
  Widget chooserButton() {
    return Container(
        padding: EdgeInsets.only(top: 13.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 25.0),
              child: Text(
                "Hastane Seçin: ",
                style: TextStyle(fontSize: 19.0),
              ),
            ),
            DropdownButton<String>(
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

                  getSections(selectedHospital);
                });
              },
            ),
            Container(
              padding: EdgeInsets.only(right: 25.0),
              child: Text(
                "Bölümü Seçin: ",
                style: TextStyle(fontSize: 19.0),
              ),
            ),
            DropdownButton<String>(
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

                  getDoctors(selectedSection);
                });
              },
            ),
            Container(
              padding: EdgeInsets.only(right: 25.0),
              child: Text(
                "Doktor Seçin: ",
                style: TextStyle(fontSize: 19.0),
              ),
            ),
            DropdownButton<String>(
              items: doctorNames.map((doktorlar) {
                return DropdownMenuItem<String>(
                  value: doktorlar,
                  child: Text(doktorlar),
                );
              }).toList(),
              value: selectedHospital,
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
        ));
  }

}