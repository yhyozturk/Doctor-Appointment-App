import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/addData.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/models/hospitalModel.dart';
import 'package:flutter/material.dart';
import 'package:fast_turtle_v2/mixins/validation_mixin.dart';

class AddHospital extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddHospitalState();
  }
}

class AddHospitalState extends State with ValidationMixin {
  final hastane = Hospital();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hastane Ekle",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.0, right: 16.0, left: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _hospitalNameField(),
                  SizedBox(
                    height: 30.0,
                  ),
                  _buildDoneButton()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _hospitalNameField() {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
            labelText: "Eklenecek Hastane Adı",
            labelStyle: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        validator: validateFirstName,
        autocorrect: false,
        onSaved: (String value) {
          hastane.hastaneAdi = value;
        },
      ),
    );
  }

  _buildDoneButton() {
    return Container(
      child: RaisedButton(
        child: Text(
          "Tamamla",
          style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          formKey.currentState.validate();
          formKey.currentState.save();
          SearchService()
              .searchHospitalByName(hastane.hastaneAdi)
              .then((QuerySnapshot docs) {
            if (docs.documents.isEmpty) {
              AddService().saveHospital(hastane);
              Navigator.pop(context, true);
            } else {
              alrtHospital(context, "Aynı isimde hastane ekleyemezsiniz");
            }
          });
        },
      ),
    );
  }

  void alrtHospital(BuildContext context, String message) {
    var alertHospital = AlertDialog(
      title: Text(
        "Uyarı!",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertHospital;
        });
  }
}
