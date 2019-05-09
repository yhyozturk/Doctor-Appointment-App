import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:flutter/material.dart';

class DeleteHospital extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DeleteHospitalState();
  }
}

class DeleteHospitalState extends State {
  var hospitalNames = [];
  var selectedHospital;

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
            "Hastane Silme Ekranı",
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
                      SizedBox(
                        height: 10.0,
                      ),
                      _silButonu()
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

  _silButonu() {
    return RaisedButton(
        child: Text(
          "Seçili Hastaneyi Sil",
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