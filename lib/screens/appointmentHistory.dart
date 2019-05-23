import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/addData.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/dbHelper/updateData.dart';
import 'package:fast_turtle_v2/models/passiveAppoModel.dart';
import 'package:fast_turtle_v2/models/userModel.dart';
import 'package:flutter/material.dart';

class AppointmentHistory extends StatefulWidget {
  final User user;
  AppointmentHistory(this.user);
  @override
  _AppointmentHistoryState createState() => _AppointmentHistoryState(user);
}

class _AppointmentHistoryState extends State<AppointmentHistory> {
  _AppointmentHistoryState(this.user);
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geçmiş Randevularınız"),
      ),
      body: _buildStremBuilder(context),
    );
  }

  _buildStremBuilder(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("tblRandevuGecmisi")
          .where('hastaTCKN', isEqualTo: user.kimlikNo)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          return _buildBody(context, snapshot.data.documents);
        }
      },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: EdgeInsets.only(top: 15.0),
      children: snapshot
          .map<Widget>((data) => _buildListItem(context, data))
          .toList(),
    );
  }

  _buildListItem(BuildContext context, DocumentSnapshot data) {
    final randevu = PassAppointment.fromSnapshot(data);
    return Padding(
      key: ValueKey(randevu.reference),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.greenAccent,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0)),
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.healing),
          ),
          title: Row(
            children: <Widget>[
              Text(
                randevu.doktorAdi.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(
                width: 3.0,
              ),
              Text(
                randevu.doktorSoyadi.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ],
          ),
          subtitle: Text(randevu.islemTarihi),
          trailing: Text(
            "Favorilere Ekle",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
          ),
          onTap: () {
            alrtFavEkle(context, randevu);
          },
        ),
      ),
    );
  }

  void alrtFavEkle(BuildContext context, PassAppointment rand) {
    var alrtRandevu = AlertDialog(
      title: Text(
        "Favorilere eklemek istediğinize emin misiniz?",
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Hayır"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          width: 5.0,
        ),
        FlatButton(
          child: Text(
            "Evet",
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            SearchService()
                .searchDocOnUserFavList(rand)
                .then((QuerySnapshot docs) {
              if (docs.documents.isEmpty) {
                AddService().addDoctorToUserFavList(rand);
                UpdateService().updateDoktorFavCountPlus(rand.doktorTCKN);
                Navigator.pop(context);
                Navigator.pop(context, true);
              } else {
                Navigator.pop(context);
                alrtHospital(context, "Favori listenizde olan bir doktoru tekrar ekleyemezsiniz.");
              }
            });
          },
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alrtRandevu;
        });
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
}
