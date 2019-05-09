import 'package:fast_turtle_v2/models/adminModel.dart';
import 'package:fast_turtle_v2/screens/addAdminPage.dart';
import 'package:fast_turtle_v2/screens/addDoctorPage.dart';
import 'package:fast_turtle_v2/screens/addHospitalPage.dart';
import 'package:fast_turtle_v2/screens/addSectionPage.dart';
import 'package:fast_turtle_v2/screens/deleteDoctorPage.dart';
import 'package:fast_turtle_v2/screens/deleteHospitalPage.dart';
import 'package:fast_turtle_v2/screens/deleteSectionPage.dart';
import 'package:fast_turtle_v2/screens/openCloseAppointmentPage.dart';
import 'package:fast_turtle_v2/screens/updateDoctorPage.dart';
import 'package:fast_turtle_v2/screens/updateHospitalPage.dart';
import 'package:fast_turtle_v2/screens/updateSectionPage.dart';
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
          _butonOlustur("Hastane Güncelle",0),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _butonOlustur("Hastane Ekle",1),
              SizedBox(
                width: 10.0,
              ),
              _butonOlustur("Hastane Sil",2),
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
          _butonOlustur("Bölüm Güncelle",3),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _butonOlustur("Bölüm Ekle",4),
              SizedBox(
                width: 10.0,
              ),
              _butonOlustur("Bölüm Sil",5),
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
          _butonOlustur("Doktor Güncelle",6),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _butonOlustur("Doktor Ekle",7),
              SizedBox(
                width: 10.0,
              ),
              _butonOlustur("Doktor Sil",8),
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
          _butonOlustur("Randevu Aç/Kapat",9),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _butonOlustur("Admin Ekle",10),
              SizedBox(
                width: 10.0,
              ),
              _butonOlustur("Çıkış Yap",11),
            ],
          )
        ],
      ),
    );
  }

  _butonOlustur(String textMessage, int buttonIndex) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: FlatButton(
        child: Text(
          textMessage,
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          switch (buttonIndex) {
            case 0:Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateHospital()));
              
              break;
            case 1:Navigator.push(context, MaterialPageRoute(builder: (context)=>AddHospital()));

              break;
            case 2:Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteHospital()));

              break;
            case 3:Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateSection()));

              break;
            case 4:Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSection()));

              break;
            case 5:Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteSection()));

              break;
            case 6:Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateDoctor()));

              break;
            case 7:Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDoctor()));

              break;
            case 8:Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteDoctor()));

              break;
            case 9:Navigator.push(context, MaterialPageRoute(builder: (context)=>OpenCloseAppointment()));

              break;
            case 10:Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAdmin()));

              break;
            case 11:Navigator.pop(context); //Logout

              break;
            default:
          }
        },
      ),
    );
  }
}
