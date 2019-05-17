import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:flutter/material.dart';

class AppointmentTimes extends StatefulWidget {
  final String randevuTarihi;
  final Doktor doktor;
  AppointmentTimes(this.randevuTarihi, this.doktor);

  @override
  _AppointmentTimesState createState() =>
      _AppointmentTimesState(randevuTarihi, doktor);
}

class _AppointmentTimesState extends State<AppointmentTimes> {
  String randevuTarihi;
  Doktor doktor;
  List<String> birlesim = [];
  List<String> saatler = [
    " , 09:00",
    " , 10:00",
    " , 11:00",
    " , 13:00",
    " , 14:00",
    " , 15:00",
    " , 16:00"
  ];

  var result;

  _AppointmentTimesState(this.randevuTarihi, this.doktor);

  @override
  void initState() {
    super.initState();
    for (var item in saatler) {
      birlesim
          .add((randevuTarihi.toString().substring(0, 10) + item).toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.access_time),
          centerTitle: true,
          title: Text("Randevu Saatleri"),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
          child: Column(
            children: <Widget>[
              chooserTime(),
            ],
          ),
        ));
  }

  chooserTime() {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildText("09:00"),
              _buildButton(0),
              _buildText("10:00"),
              _buildButton(1),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildText("11:00"),
              _buildButton(2),
              _buildText("12:00"),
              _buildButton(3),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 13.0, bottom: 13.0),
          child: Text(
            "Öğle Arası",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildText("14:00"),
              _buildButton(4),
              _buildText("15:00"),
              _buildButton(5),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildText("16:00"),
              _buildButton(6),
              _buildText("17:00"),
              _buildButton(7),
            ],
          ),
        ),
      ],
    );
  }

  _buildText(String saat) {
    return Text(
      saat,
      style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
    );
  }

  _buildButton(int index) {
    return RaisedButton(
      child: Text(
        "Seç",
        style: TextStyle(fontSize: 12.0),
      ),
      onPressed: () {
        _buttonPressEvent(index);
      },
    );
  }

  _buttonPressEvent(int index) {

     Navigator.pop(context, birlesim[index]);
    // if (result == true) {
    //   Navigator.pop(context, birlesim[index]);
    // } else if (result == false) {
    //   alrtHospital(context, "Doktorun bu saat için randevusu mevcut");
    // }
  }

  Future<bool> timeControl(int index) async {
    result = await SearchService()
        .searchDoctorAppointment(doktor, birlesim[index])
        .then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        return false;
      } else {
        return true;
      }
    });
    return result;
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
}
