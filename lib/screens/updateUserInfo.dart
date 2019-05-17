import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/dbHelper/updateData.dart';
import 'package:fast_turtle_v2/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:fast_turtle_v2/mixins/validation_mixin.dart';

class UpdateUser extends StatefulWidget {
  final User user;
  UpdateUser(this.user);
  @override
  _UpdateUserState createState() => _UpdateUserState(user);
}

class _UpdateUserState extends State<UpdateUser> with ValidationMixin {
  _UpdateUserState(this.user);
  User user = User();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bilgileri Güncelle"),
      ),
      backgroundColor: Colors.limeAccent,
      body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 35.0, left: 13.0, right: 13.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                firstNameField(),
                lastNameField(),
                sifreField(),
                SizedBox(
                  height: 25.0,
                ),
                buildSubmitButton()
              ],
            ),
          )),
    );
  }

  Widget sifreField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Şifre",
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      onSaved: (String value) {
        user.sifre = value;
      },
      obscureText: true,
    );
  }

  Widget firstNameField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Ad",
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      validator: validateFirstName,
      onSaved: (String value) {
        user.adi = value;
      },
    );
  }

  Widget lastNameField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Soyad",
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      validator: validateLastName,
      onSaved: (String value) {
        user.soyadi = value;
      },
    );
  }

  buildSubmitButton() {
    return Container(
      padding: EdgeInsets.only(right: 5.0, left: 5.0),
      width: 200.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(13.0),
          ),
          color: Colors.black),
      child: RaisedButton(
        child: Text("Tamamla",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20.0)),
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            SearchService()
                .searchUserById(user.kimlikNo)
                .then((QuerySnapshot docs) {
              user.reference = docs.documents[0].reference;
              UpdateService().updateUser(user);
            });

            Navigator.pop(context, true);
          }
        },
      ),
    );
  }
}
