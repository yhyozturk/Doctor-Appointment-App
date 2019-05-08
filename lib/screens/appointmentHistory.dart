import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/models/appointmentModel.dart';
import 'package:flutter/material.dart';

class AppointmentHistory extends StatefulWidget {
  @override
  AppointmentHistoryState createState() => AppointmentHistoryState();
}

class AppointmentHistoryState extends State<AppointmentHistory> {
  var randevuDoktorlar = [];
  var randevuIslemTarihi = [];
  var randevuKayitID = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    getAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Randevu Geçmişi",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: showAppointments(),
    );
  }

  getAppointments() {
    SearchService().searchAppointmentsByHastaTCKN("55555555555").then((QuerySnapshot docs) {
      //List<Appointment> gelenKayitlar = new List<Appointment>();
      //gelenKayitlar = List<Appointment>(docs.documents);
      int randevuSayisi = 0;
      for (var i = 0; i < docs.documents.length; i++) {
          randevuDoktorlar.add(docs.documents[i]['doktorTCKN']);
          randevuIslemTarihi.add(docs.documents[i]['islemTarihi']);
          randevuKayitID.add(docs.documents[i]['kayitId']);
          randevuSayisi++;
      }

      setState(() {
        //randevular = gelenKayitlar;
        randevuDoktorlar = randevuDoktorlar;
        randevuIslemTarihi = randevuIslemTarihi;
        randevuKayitID = randevuKayitID;
        count = randevuSayisi;
      });
    });
  }

  ListView showAppointments() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.amberAccent,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text(randevuKayitID[position].toString()),
            ),
            title: Text(randevuDoktorlar[
                position]), // this.randevular[position].kayitId.toString()
            subtitle: Text(randevuIslemTarihi[
                position]), // this.randevular[position].islemTarihi
            onTap: () {
              //randevuDetay(this.randevular[position]);
            },
          ),
        );
      },
    );
  }
}
