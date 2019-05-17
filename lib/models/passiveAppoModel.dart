import 'package:cloud_firestore/cloud_firestore.dart';

class PassAppointment {
  int kayitId;
  String doktorTCKN;
  String hastaTCKN;
  String islemTarihi;

  DocumentReference reference;

  PassAppointment({this.kayitId, this.doktorTCKN, this.hastaTCKN, this.islemTarihi});

  PassAppointment.fromJson(Map<String, dynamic> json) {
    kayitId = json['kayitId'];
    doktorTCKN = json['doktorTCKN'];
    hastaTCKN = json['hastaTCKN'];
    islemTarihi = json['islemTarihi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kayitId'] = this.kayitId;
    data['doktorTCKN'] = this.doktorTCKN;
    data['hastaTCKN'] = this.hastaTCKN;
    data['islemTarihi'] = this.islemTarihi;
    return data;
  }

  PassAppointment.fromMap(Map<String, dynamic> map, {this.reference})
      : kayitId = map['kayitId'],
        doktorTCKN = map['doktorTCKN'],
        hastaTCKN = map['hastaTCKN'],
        islemTarihi = map['islemTarihi'];

  PassAppointment.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
