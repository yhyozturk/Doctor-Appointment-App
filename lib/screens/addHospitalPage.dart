import 'package:flutter/material.dart';

class AddHospital extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddHospitalState();
  }
}

class AddHospitalState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hastane Ekle",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Çok Yakında",
              style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
