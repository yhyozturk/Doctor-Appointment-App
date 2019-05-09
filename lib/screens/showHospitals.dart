import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/models/hospitalModel.dart';
import 'package:flutter/material.dart';

class BuildHospitalList extends StatefulWidget {
  @override
  _BuildHospitalListState createState() => _BuildHospitalListState();
}

class _BuildHospitalListState extends State<BuildHospitalList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hastaneler"),
      ),
      body: _buildStremBuilder(context),
    );
  }

  _buildStremBuilder(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("tblHastane").snapshots(),
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
    final hastane = Hospital.fromSnapshot(data);
    return Padding(
      key: ValueKey(hastane.hastaneId),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0)),
        child: ListTile(
          title: Text(hastane.hastaneAdi),
          onTap: () {
            Navigator.pop(context, hastane);
          },
        ),
      ),
    );
  }
}
