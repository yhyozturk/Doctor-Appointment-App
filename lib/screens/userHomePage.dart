import 'package:fast_turtle_v2/models/userModel.dart';
import 'package:fast_turtle_v2/screens/appointmentHistory.dart';
import 'package:fast_turtle_v2/screens/makeAppointment.dart';
import 'package:fast_turtle_v2/screens/showActiveAppo.dart';
import 'package:fast_turtle_v2/screens/showUserFavList.dart';
import 'package:fast_turtle_v2/screens/updateUserInfo.dart';
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
                      _buildAttributeRow(
                          "Doğum Yeri", kullanici.dogumYeri.toString()),
                      _buildAttributeRow(
                          "Doğum Tarihi", kullanici.dogumTarihi.toString()),
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
                    _aktifRandevularButonu(),
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
                    _favoriListesiButonu(),
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
          onPressed: () {
            basicNavigator(MakeAppointment(kullanici),
                "Randevu Kaydınız Başarıyla Alındı. Şimdiden Geçmiş Olsun :)");
          }),
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
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AppointmentHistory(kullanici))),
      ),
    );
  }

  _aktifRandevularButonu() {
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
            "Aktif Randevuları Listele",
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            basicNavigator(BuildAppointmentList(kullanici), "İşlem Tamamlandı");
          }),
    );
  }

  _favoriListesiButonu() {
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
            "Favorileri Görüntüle",
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            basicNavigator(BuildUserFavList(kullanici), "İşlem Tamamlandı");
          }),
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
          "Bilgileri Güncelle",
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          basicNavigator(UpdateUser(kullanici), "İşlem Tamamlandı");
        },
      ),
    );
  }

  void basicNavigator(dynamic page, String message) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));

    if (result != null && result == true) {
      alrtHospital(context, message);
    }
  }

  void alrtHospital(BuildContext context, String message) {
    var alertDoctor = AlertDialog(
      title: Text(
        "Bilgilendirme!",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(message),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDoctor;
        });
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
          "Güvenli Çıkış",
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
