import 'package:fast_turtle_v2/models/adminModel.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  final Admin admin;
  AdminHomePage(this.admin);

  @override
  _AdminHomePageState createState() => _AdminHomePageState(admin);
}

class _AdminHomePageState extends State<AdminHomePage> {
  Admin _admin;
  _AdminHomePageState(this._admin);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          leading: Icon(Icons.timeline),
          backgroundColor: Colors.deepOrangeAccent,
          title: Text(
            "Admin Ana Sayfası",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _bodyTitle(),
              _buildTitle("Hastane İşlemleri"),
              SizedBox(
                height: 9.0,
              ),
              _hastaneIslemButonlari(),
              SizedBox(
                height: 9.0,
              ),
              _buildTitle("Bölüm İşlemleri"),
              SizedBox(
                height: 9.0,
              ),
              _bolumIslemButonlari(),
              SizedBox(
                height: 9.0,
              ),
              _buildTitle("Doktor İşlemleri"),
              SizedBox(
                height: 9.0,
              ),
              _doktorIslemButonlari(),
              SizedBox(
                height: 9.0,
              ),
              _buildTitle("Diğer İşlemler"),
              SizedBox(
                height: 9.0,
              ),
              _digerIslemButonlari()
            ],
          ),
        ));
  }

  _bodyTitle() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.0, left: 26.0, right: 26.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 10.0,
          ),
          Text(
            "Id:" + _admin.id.toString(),
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            _admin.nickname,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  _buildTitle(String textMessage) {
    return Container(
      padding: EdgeInsets.only(top: 18.0, left: 15.0, right: 15.0),
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15.0),
            alignment: Alignment.centerLeft,
            child: Text(
              textMessage,
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
          Container(
            color: Colors.grey,
            width: 370.0,
            height: 0.7,
          ),
        ],
      ),
    );
  }

  _hastaneIslemButonlari() {
    return Container(
      child: Column(
        children: <Widget>[
          _butonOlustur("Hastane Güncelle"),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _butonOlustur("Hastane Ekle"),
              SizedBox(
                width: 10.0,
              ),
              _butonOlustur("Hastane Sil"),
            ],
          )
        ],
      ),
    );
  }

  _bolumIslemButonlari() {
    return Container(
      child: Column(
        children: <Widget>[
          _butonOlustur("Bölüm Güncelle"),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _butonOlustur("Bölüm Ekle"),
              SizedBox(
                width: 10.0,
              ),
              _butonOlustur("Bölüm Sil"),
            ],
          )
        ],
      ),
    );
  }

  _doktorIslemButonlari() {
    return Container(
      child: Column(
        children: <Widget>[
          _butonOlustur("Doktor Güncelle"),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _butonOlustur("Doktor Ekle"),
              SizedBox(
                width: 10.0,
              ),
              _butonOlustur("Doktor Sil"),
            ],
          )
        ],
      ),
    );
  }

  _digerIslemButonlari() {
    return Container(
      child: Column(
        children: <Widget>[
          _butonOlustur("Randevu Aç/Kapat"),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _butonOlustur("Admin Ekle"),
              SizedBox(
                width: 10.0,
              ),
              _butonOlustur("Çıkış Yap"),
            ],
          )
        ],
      ),
    );
  }

  _butonOlustur(String textMessage) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: FlatButton(
        child: Text(
          textMessage,
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {},
      ),
    );
  }
}
