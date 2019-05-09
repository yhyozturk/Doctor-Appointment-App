import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/models/hospitalModel.dart';
import 'package:fast_turtle_v2/models/sectionModel.dart';
import 'package:flutter/material.dart';

class BuildSectionList extends StatefulWidget {
  final Hospital _hospital;
  BuildSectionList(this._hospital);

  @override
  _BuildSectionListState createState() => _BuildSectionListState(_hospital);
}

class _BuildSectionListState extends State<BuildSectionList> {
  Hospital _hospital;
  _BuildSectionListState(this._hospital);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bölümler"),
      ),
      body: _buildStremBuilder(context),
    );
  }

  _buildStremBuilder(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("tblBolum")
          .where("hastaneId", isEqualTo: _hospital.hastaneId)
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
    final section = Section.fromSnapshot(data);
    return Padding(
      key: ValueKey(section.bolumId),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0)),
        child: ListTile(
          title: Text(section.bolumAdi),
          onTap: () {
            Navigator.pop(context, section);
          },
        ),
      ),
    );
  }
}
