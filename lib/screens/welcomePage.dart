import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/models/adminModel.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:fast_turtle_v2/models/userModel.dart';
import 'package:fast_turtle_v2/screens/adminHomePage.dart';
import 'package:fast_turtle_v2/screens/doctorHomePage.dart';
import 'package:fast_turtle_v2/screens/registerPage.dart';
import 'package:fast_turtle_v2/screens/userHomePage.dart';
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
  User user = User();
  Doktor doktor = Doktor();
  Admin admin = Admin();
  Future<QuerySnapshot> gelenVeri;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    this.gelenVeri =
        Firestore.instance.collection('tblKullanici').getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fast Anadolu Randevu Sistemi",
          textDirection: TextDirection.ltr,
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white70,
          tabs: <Widget>[
            Text(
              "Kullanıcı",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "Doktor",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "Admin",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                pagePlanWithForm(kimlikNoField(0, context), sifreField(0),
                    "Hoşgeldiniz", kullaniciFormKey),
                registerButton()
              ])),
          pagePlanWithForm(kimlikNoField(1, context), sifreField(1),
              "Doktor Girişi", doktorFormKey),
          pagePlanWithForm(
              adminNicknameField(), sifreField(2), "Admin Girişi", adminFormKey)
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
      style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
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
              mainAxisAlignment: MainAxisAlignment.center,
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

  Widget kimlikNoField(int tabIndex, BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "T.C. Kimlik Numarası:",
        labelStyle: TextStyle(
            fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      onSaved: (String value) {
        if (tabIndex == 0) {
          user.kimlikNo = value;
        } else {
          doktor.kimlikNo = value;
        }
      },
    );
  }

  Widget sifreField(int tabIndex) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Şifre:",
        labelStyle: TextStyle(
            fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      validator: validatePassword,
      obscureText: true,
      onSaved: (String value) {
        if (tabIndex == 0) {
          user.sifre = value;
        } else if (tabIndex == 1) {
          doktor.sifre = value;
        } else {
          admin.password = value;
        }
      },
    );
  }

  Widget adminNicknameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Kullanıcı Adı:"),
      validator: validateAdmin,
      onSaved: (String value) {
        admin.nickname = value;
      },
    );
  }

  bool kimlikNoDogrula = false;
  bool sifreDogrula = false;
  var tempSearchStore = [];

  //girilen kimlik numarasına kayıtlı bir kullanıcı olup olmadıpını arayan metot...
  initiateSearch(girilenId, gelenPassword, int tabIndex, String searchWhere,
      String searchPass) {
    SearchService()
        .searchById(girilenId, gelenPassword, tabIndex)
        .then((QuerySnapshot docs) {
      for (int i = 0; i < docs.documents.length; i++) {
        tempSearchStore.add(docs.documents[i].data);

        if (tabIndex == 0) {
          user = User.fromMap(docs.documents[i].data);
        } else if (tabIndex == 1) {
          doktor = Doktor.fromMap(docs.documents[i].data);
        } else if (tabIndex == 2) {
          admin = Admin.fromMap(docs.documents[i].data);
        }
      }
    });
    for (var item in tempSearchStore) {
      if (item[searchWhere] == girilenId && item[searchPass] == gelenPassword) {
        kimlikNoDogrula = true;
        sifreDogrula = true;
      }
    }
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
          kimlikNoDogrula = false;
          sifreDogrula = false;
          formKey.currentState.validate();
          formKey.currentState.save();
          if (formKey == kullaniciFormKey) {
            initiateSearch(user.kimlikNo, user.sifre, 0, 'kimlikNo', 'sifre');

            if (kimlikNoDogrula && sifreDogrula) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserHomePage(user)));
            }
          } else if (formKey == doktorFormKey) {
            initiateSearch(
                doktor.kimlikNo, doktor.sifre, 1, 'kimlikNo', 'sifre');

            if (kimlikNoDogrula && sifreDogrula) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DoctorHomePage(doktor)));
            }
          } else if (formKey == adminFormKey) {
            initiateSearch(
                admin.nickname, admin.password, 2, 'nickname', 'password');

            if (kimlikNoDogrula && sifreDogrula) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminHomePage(admin)));
            }
          }
        },
      ),
    );
  }
}
