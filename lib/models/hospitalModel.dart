import 'package:cloud_firestore/cloud_firestore.dart';

class Hospital {
  String hastaneAdi;
  int hastaneId;

  Hospital({this.hastaneAdi, this.hastaneId});

  DocumentReference reference;

  Hospital.fromJson(Map<String, dynamic> json) {
    hastaneAdi = json['hastaneAdi'];
    hastaneId = json['hastaneId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hastaneAdi'] = this.hastaneAdi;
    data['hastaneId'] = this.hastaneId;
    return data;
  }

  Hospital.fromMap(Map<String, dynamic> map, {this.reference})
      : hastaneAdi = map["hastaneAdi"],
        hastaneId = map["hastaneId"];

  Hospital.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
