import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:fast_turtle_v2/models/hospitalModel.dart';
import 'package:fast_turtle_v2/models/sectionModel.dart';
import 'package:flutter/material.dart';

class BuildDoctorList extends StatefulWidget {
  final Section _section;
  final Hospital _hospital;
  BuildDoctorList(this._section, this._hospital);

  @override
  _BuildDoctorListState createState() =>
      _BuildDoctorListState(_section, _hospital);
}

class _BuildDoctorListState extends State<BuildDoctorList> {
  Section section;
  Hospital hospital;
  _BuildDoctorListState(this.section, this.hospital);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doktorlar"),
      ),
      body: _buildStremBuilder(context),
    );
  }

  _buildStremBuilder(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("tblDoktor")
          .where("hastaneId", isEqualTo: hospital.hastaneId)
          .where("bolumId", isEqualTo: section.bolumId)
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
    final dr = Doktor.fromSnapshot(data);
    return Padding(
      key: ValueKey(dr.kimlikNo),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0)),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Text(dr.adi),
              SizedBox(
                width: 5.0,
              ),
              Text(dr.soyadi)
            ],
          ),
          subtitle: Text(section.bolumAdi),
          onTap: () {
            Navigator.pop(context, dr);
          },
        ),
      ),
    );
  }
}
