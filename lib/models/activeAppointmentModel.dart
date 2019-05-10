import 'package:cloud_firestore/cloud_firestore.dart';

class ActiveAppointment {
  String doktorTCKN;
  String hastaTCKN;
  int randId;
  String randevuTarihi;
  DocumentReference reference;

  ActiveAppointment(
      {this.doktorTCKN, this.hastaTCKN, this.randId, this.randevuTarihi});

  ActiveAppointment.fromJson(Map<String, dynamic> json) {
    doktorTCKN = json['doktorTCKN'];
    hastaTCKN = json['hastaTCKN'];
    randId = json['randId'];
    randevuTarihi = json['randevuTarihi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doktorTCKN'] = this.doktorTCKN;
    data['hastaTCKN'] = this.hastaTCKN;
    data['randId'] = this.randId;
    data['randevuTarihi'] = this.randevuTarihi;
    return data;
  }

  ActiveAppointment.fromMap(Map<String, dynamic> map, {this.reference})
      : doktorTCKN = map["doktorTCKN"],
        hastaTCKN = map["hastaTCKN"],
        randId = map["randId"],
        randevuTarihi = map["randevuTarihi"];

  ActiveAppointment.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
