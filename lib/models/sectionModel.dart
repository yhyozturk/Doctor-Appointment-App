import 'package:cloud_firestore/cloud_firestore.dart';

class Section {
  String bolumAdi;
  int bolumId;
  int hastaneId;

  DocumentReference reference;

  Section({this.bolumAdi, this.bolumId, this.hastaneId});

  Section.fromJson(Map<String, dynamic> json) {
    bolumAdi = json['bolumAdi'];
    bolumId = json['bolumId'];
    hastaneId = json['hastaneId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bolumAdi'] = this.bolumAdi;
    data['bolumId'] = this.bolumId;
    data['hastaneId'] = this.hastaneId;
    return data;
  }

  Section.fromMap(Map<String, dynamic> map, {this.reference})
      : bolumAdi = map["bolumAdi"],
        bolumId = map["bolumId"],
        hastaneId = map["hastaneId"];

  Section.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
