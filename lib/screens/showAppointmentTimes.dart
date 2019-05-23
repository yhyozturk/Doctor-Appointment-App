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
  List<bool> birlesimKontrol = [];
  List<String> saatler = [
    " , 09:00",
    " , 10:00",
    " , 11:00",
    " , 13:00",
    " , 14:00",
    " , 15:00",
    " , 16:00"
  ];

  var result = "Seç";

  _AppointmentTimesState(this.randevuTarihi, this.doktor);

  @override
  void initState() {
    super.initState();
    for (var item in saatler) {
      birlesim
          .add((randevuTarihi.toString().substring(0, 10) + item).toString());
    }
    for (var i = 0; i < birlesim.length; i++) {
      if (doktor.randevular.contains(birlesim[i])) {
        birlesimKontrol.insert(i, false);
      } else {
        birlesimKontrol.insert(i, true);
      }
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
          padding: EdgeInsets.only(top: 50.0, left: 25.0, right: 30.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  "Belirtilen saatler randevu başlangıç saatleridir. Her randevuya 1 saat ayrılmaktadır.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
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
              _buildButton(0, result),
              _buildText("10:00"),
              _buildButton(1, result),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildText("11:00"),
              SizedBox(
                width: 20.0,
              ),
              _buildButton(2, result),
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
              _buildText("13:00"),
              _buildButton(3, result),
              _buildText("14:00"),
              _buildButton(4, result),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildText("15:00"),
              _buildButton(5, result),
              _buildText("16:00"),
              _buildButton(6, result),
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

  _buildButton(int index, String textMessage) {
    chooseColor() {
      if (birlesimKontrol[index]) {
        return Colors.greenAccent;
      } else {
        return Colors.redAccent;
      }
    }

    return Container(
      decoration: BoxDecoration(color: chooseColor()),
      child: FlatButton(
        child: Text(
          textMessage,
          style: TextStyle(fontSize: 12.0),
        ),
        onPressed: () {
          _buttonPressEvent(index);
        },
      ),
    );
  }

  _buttonPressEvent(int index) {
    if (birlesimKontrol[index]) {
      Navigator.pop(context, birlesim[index]);
    } else {
      alrtHospital(context, "Bu seans seçilemez.");
    }
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
