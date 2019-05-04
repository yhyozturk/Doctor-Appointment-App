import 'package:flutter/material.dart';
import 'package:fast_turtle_v2/mixins/validation_mixin.dart';
import 'package:fast_turtle_v2/screens/welcomePage.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State with ValidationMixin {
  final registerFormKey = GlobalKey<FormState>();
  WelcomePageState _welcomePageState = WelcomePageState();

  var genders = ["Kadın", "Erkek"];
  var selectedGenders = "Kadın";
  var dogumTarihi;
  var raisedButtonText = "Tıkla ve Seç";

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    dogumTarihi = picked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Yeni Üye Kaydı"),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
              child: Form(
                key: registerFormKey,
                child: Column(
                  children: <Widget>[
                    _welcomePageState.kimlikNoField(),
                    _welcomePageState.sifreField(),
                    firstNameField(),
                    lastNameField(),
                    placeofBirthField(),
                    genderChoose(),
                    dateOfBirth(),
                    submitButton()
                  ],
                ),
              )),
        ));
  }

  static void alrtDone(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Kayıt Başarılı"),
      content: Text("Giriş Yapabilirsiniz"),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void alrtFail(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Kayıt Başarısız"),
      content: Text("Hatalı yada eksik bilgi girdiniz"),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void basicPop(BuildContext context, bool result) {
    Navigator.pop(context, result);
  }

  Widget firstNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Ad"),
      validator: validateFirstName,
    );
  }

  Widget lastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Soyad"),
      validator: validateLastName,
    );
  }

  Widget placeofBirthField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Doğum Yeri"),
    );
  }

  Widget genderChoose() {
    return Container(
        padding: EdgeInsets.only(top: 13.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 25.0),
              child: Text(
                "Cinsiyet: ",
                style: TextStyle(fontSize: 19.0),
              ),
            ),
            DropdownButton<String>(
              items: genders.map((String cinsiyetler) {
                return DropdownMenuItem<String>(
                  value: cinsiyetler,
                  child: Text(cinsiyetler),
                );
              }).toList(),
              value: selectedGenders,
              onChanged: (String tiklanan) {
                setState(() {
                  this.selectedGenders = tiklanan;
                });
              },
            ),
          ],
        ));
  }

  Widget dateOfBirth() {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child: Row(
        children: <Widget>[
          Text(
            "Doğum Tarihi: ",
            style: TextStyle(fontSize: 19.0),
          ),
          RaisedButton(
            child: Text(raisedButtonText),
            onPressed: () {
              _selectDate(context).then((result) => setState(() {
                    raisedButtonText = dogumTarihi.toString();
                  }));
            },
          )
        ],
      ),
    );
  }

  Widget submitButton() {
    return Container(
      padding: EdgeInsets.only(top: 45.0),
      child: RaisedButton(
        child: Text(
          "Tamamla",
          textDirection: TextDirection.ltr,
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          if (registerFormKey.currentState.validate()) {
            basicPop(context, true);
          }
          //  else {
          //   alrtFail(context);
          // }
        },
      ),
    );
  }
}
