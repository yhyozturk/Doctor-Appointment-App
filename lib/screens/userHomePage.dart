import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserHomePageState();
  }
}

class UserHomePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Kullanıcı Ana Sayfası"),
        ),
        body: Center(
          child: Text(
            "Çok Yakında! :D",
            style: TextStyle(fontSize: 50.0),
          ),
        ));
  }
}
