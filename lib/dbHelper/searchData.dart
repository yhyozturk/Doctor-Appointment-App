import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DataSearchState();
  }
}

class DataSearchState extends State {
  @override
  Widget build(BuildContext context) {
    return searchById(context);
  }



 String kimLikNo;


  searchById(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('tblKullanici').snapshots(),
      builder: (context, snapshot){
        if (snapshot.hasData) {
          kimLikNo= snapshot.data.documents[0]['kimlikNo'];
          return Text(kimLikNo);
        }
      },
    );
  }
}
