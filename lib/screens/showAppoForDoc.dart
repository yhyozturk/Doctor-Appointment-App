import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/addData.dart';
import 'package:fast_turtle_v2/dbHelper/delData.dart';
import 'package:fast_turtle_v2/dbHelper/updateData.dart';
import 'package:fast_turtle_v2/models/activeAppointmentModel.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:flutter/material.dart';

class BuildAppointmentListForDoctor extends StatefulWidget {
  final Doktor doktor;
  BuildAppointmentListForDoctor(this.doktor);
  @override
  _BuildAppointmentListState createState() =>
      _BuildAppointmentListState(doktor);
}

class _BuildAppointmentListState extends State<BuildAppointmentListForDoctor> {
  Doktor doktor;
  _BuildAppointmentListState(this.doktor);

  String gonder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bekleyen Randevularınız"),
      ),
      body: _buildStremBuilder(context),
    );
  }

  _buildStremBuilder(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("tblAktifRandevu")
          .where('doktorTCKN', isEqualTo: doktor.kimlikNo)
          .where('randevuTarihi',
              isLessThanOrEqualTo: (DateTime.now()
                  .add(Duration(days: 30))
                  .toString()
                  .substring(0, 10)))
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
    final randevu = ActiveAppointment.fromSnapshot(data);
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
            child: Icon(Icons.person),
          ),
          title: Row(
            children: <Widget>[
              Text(
                randevu.hastaAdi.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(
                width: 3.0,
              ),
              Text(
                randevu.hastaSoyadi.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ],
          ),
          subtitle: Text(randevu.randevuTarihi),
          trailing: Text(
            "Tamamla",
            style:
                TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            alrtRandevuTamamla(context, randevu);
          },
        ),
      ),
    );
  }

  void alrtRandevuTamamla(BuildContext context, ActiveAppointment rand) {
    var alrtRandevu = AlertDialog(
      title: Text(
        "Randevuyu Bitir",
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Evet",
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            UpdateService()
                .updateDoctorAppointments(doktor.kimlikNo, rand.randevuTarihi);
            DelService().deleteActiveAppointment(rand);
            AddService().addPastAppointment(rand);
            Navigator.pop(context);
            Navigator.pop(context);
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
}
