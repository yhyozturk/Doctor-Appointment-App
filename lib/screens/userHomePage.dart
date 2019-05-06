import 'package:fast_turtle_v2/models/userModel.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  final User user;

  UserHomePage(this.user);

  @override
  State<StatefulWidget> createState() {
    return UserHomePageState(user);
  }
}

class UserHomePageState extends State {
  User kullanici;
  UserHomePageState(this.kullanici);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
          title: Text("Kullanıcı Ana Sayfası"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 30.0, left: 5.0, right: 5.0, bottom: 25.0),
                color: Colors.blueAccent[200],
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 13.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 18.0),
                            child: Icon(
                              Icons.person,
                              size: 50.0,
                            ),
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          Container(
                            child: Text(
                              kullanici.adi,
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Container(
                            child: Text(
                              kullanici.soyadi,
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Container(
                        color: Colors.grey,
                        width: 370.0,
                        height: 0.4,
                      ),
                      _buildAttributeRow(
                          "T.C. Kimlik Numarası", kullanici.kimlikNo),
                      _buildAttributeRow(
                          "Cinsiyet", kullanici.cinsiyet.toString()),
                      _buildAttributeRow("Doğum Yeri", kullanici.dogumYeri),
                      _buildAttributeRow("Doğum Tarihi", kullanici.dogumTarihi),
                      SizedBox(
                        height: 30.0,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: screenSize.width,
                height: screenSize.height / 2,
                color: Colors.blueAccent[200],
                child: Column(
                  children: <Widget>[
                    _randevuAlButonu(),
                    SizedBox(
                      height: 5.0,
                    ),
                    _randevuGecmisiButonu(),
                    SizedBox(
                      height: 5.0,
                    ),
                    _hesapBilgileriButonu(),
                    SizedBox(
                      height: 5.0,
                    ),
                    _cikisYapButonu()
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildAttributeRow(var textMessage, var textValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0, left: 13.0),
          child: Container(
            alignment: Alignment.center,
            color: Colors.greenAccent,
            width: 200.0,
            height: 25.0,
            child: Text(
              textMessage,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          width: 25.0,
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0, left: 13.0),
          child: Container(
            child: Text(
              textValue,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  _randevuAlButonu() {
    return Container(
      padding: EdgeInsets.all(1.0),
      width: 390.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white),
      child: FlatButton(
        splashColor: Colors.grey,
        highlightColor: Colors.white70,
        child: Text(
          "Randevu Al",
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {},
      ),
    );
  }

  _randevuGecmisiButonu() {
    return Container(
      padding: EdgeInsets.all(1.0),
      width: 390.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white),
      child: FlatButton(
        splashColor: Colors.grey,
        highlightColor: Colors.white70,
        child: Text(
          "Randevu Geçmişi",
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {},
      ),
    );
  }

  _hesapBilgileriButonu() {
    return Container(
      padding: EdgeInsets.all(1.0),
      width: 390.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white),
      child: FlatButton(
        splashColor: Colors.grey,
        highlightColor: Colors.white70,
        child: Text(
          "Hesap Bilgileri",
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {},
      ),
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
          "Farklı Kullanıcı ile Giriş",
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {},
      ),
    );
  }
}
