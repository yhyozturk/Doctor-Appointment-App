import 'package:fast_turtle_v2/screens/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:fast_turtle_v2/mixins/validation_mixin.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WelcomePageState();
  }
}

class WelcomePageState extends State
    with SingleTickerProviderStateMixin, ValidationMixin {
  TabController _tabController;
  final kullaniciFormKey = GlobalKey<FormState>();
  final doktorFormKey = GlobalKey<FormState>();
  final adminFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FastTurtle Randevu Sistemi",
          textDirection: TextDirection.ltr,
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white70,
          tabs: <Widget>[
            Text(
              "Kullanıcı",
              style: TextStyle(fontSize: 15.0),
            ),
            Text("Doktor"),
            Text("Admin")
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          SingleChildScrollView(
              child: Column(children: <Widget>[
            pagePlanWithForm(
                kimlikNoField(), sifreField(), "Hoşgeldiniz", kullaniciFormKey),
            registerButton()
          ])),
          pagePlanWithForm(
              kimlikNoField(), sifreField(), "Doktor Girişi", doktorFormKey),
          pagePlanWithForm(
              adminNicknameField(), sifreField(), "Admin Girişi", adminFormKey)
        ],
      ),
    );
  }

  void basicNavigator(dynamic page) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));

    if (result != null && result == true) {
      RegisterPageState.alrtDone(context);
    }
  }

  Container registerButton() {
    return Container(
      // padding: EdgeInsets.only(top: 5.0),
      child: FlatButton(
        child: Text(
          "Kayıt Ol",
          style: TextStyle(fontSize: 15.0),
        ),
        textColor: Colors.black,
        splashColor: Colors.cyanAccent,
        onPressed: () {
          basicNavigator(RegisterPage());
        },
      ),
    );
  }

  /*Container pagePlan(String pageHeader, String labelText) {
    return Container(
        padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
        // singlechildscrollview olmazsa, textfield a veri girişi yapılmak istendiğinde ekrana klavye de yerleşiyor ve görüntü bozuluyor, ...
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 13.0, bottom: 10.0),
                  child: pageHeaderPlan(pageHeader)),
              TextField(
                  controller: txtTCNO,
                  maxLength: 11,
                  decoration: labelTextPlan(labelText)),
              TextField(
                controller: txtSifre,
                decoration: InputDecoration(labelText: "Şifre"),
              ),
              Container(
                padding: EdgeInsets.only(top: 30.0),
                child: FlatButton(
                  child: Text(
                    "Giriş Yap",
                    style: TextStyle(fontSize: 22.0),
                  ),
                  textColor: Colors.blueAccent,
                  splashColor: Colors.cyanAccent,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ));
  } */

  InputDecoration labelTextPlan(String value) {
    return InputDecoration(labelText: value);
  }

  Text pageHeaderPlan(String value) {
    return Text(
      value,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: TextStyle(fontSize: 40.0),
    );
  }

  Container pagePlanWithForm(Widget firstTextField, Widget secondTextField,
      String pageHeader, GlobalKey<FormState> formKey) {
    return Container(
        margin: EdgeInsets.only(top: 25.0, right: 25.0, left: 25.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 13.0, bottom: 10.0),
                  child: pageHeaderPlan(pageHeader),
                ),
                firstTextField,
                secondTextField,
                loginButton(formKey)
              ],
            ),
          ),
        ));
  }

  Widget kimlikNoField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "T.C. Kimlik Numarası:"),
      validator: validateTCNo,
    );
  }

  Widget sifreField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Şifre:"),
    );
  }

  Widget adminNicknameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Kullanıcı Adı:"),
      validator: validateAdmin,
    );
  }

  Widget loginButton(GlobalKey<FormState> formKey) {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      child: FlatButton(
        child: Text(
          "Giriş Yap",
          style: TextStyle(fontSize: 22.0),
        ),
        textColor: Colors.blueAccent,
        splashColor: Colors.cyanAccent,
        onPressed: () {
          if (formKey.currentState.validate()) {
            print("İşlem tamam");
          }
        },
      ),
    );
  }
}
