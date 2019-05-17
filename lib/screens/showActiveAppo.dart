import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/models/activeAppointmentModel.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:fast_turtle_v2/models/userModel.dart';
import 'package:flutter/material.dart';

class BuildAppointmentList extends StatefulWidget {
  final User user;
  BuildAppointmentList(this.user);
  @override
  _BuildAppointmentListState createState() => _BuildAppointmentListState(user);
}

class _BuildAppointmentListState extends State<BuildAppointmentList> {
  User user;
  _BuildAppointmentListState(this.user);
  Doktor doktor = Doktor();
  Doktor doktor2 = Doktor();

  String gonder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aktif Randevularınız"),
      ),
      body: _buildStremBuilder(context),
    );
  }

  _buildStremBuilder(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("tblAktifRandevu")
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
    final randevu = ActiveAppointment.fromSnapshot(data);
    findDoktorName(randevu.doktorTCKN).then((value) {
      setState(() {
        gonder =
            (doktor.adi.toString() + " " + doktor.soyadi.toString()).toString();
      });
    });
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
          title: Text(
            gonder.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          subtitle: Text(randevu.randevuTarihi),
          onTap: () {},
        ),
      ),
    );
  }

  Future<Null> findDoktorName(String sentId) async {
    final Doktor value = await SearchService()
        .searchDoctorById(sentId)
        .then((QuerySnapshot docs) {
      doktor = Doktor.fromMap(docs.documents[0].data);
    });
    doktor2 = value;
  }
}
