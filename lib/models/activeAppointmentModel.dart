import 'package:cloud_firestore/cloud_firestore.dart';

class ActiveAppointment {
  String doktorTCKN;
  String doktorAdi;
  String hastaTCKN;
  String hastaAdi;
  int randId;
  String randevuTarihi;
  DocumentReference reference;
  String doktorSoyadi;
  String hastaSoyadi;

  ActiveAppointment(
      {this.doktorTCKN,
      this.hastaTCKN,
      this.randId,
      this.randevuTarihi,
      this.doktorAdi,
      this.doktorSoyadi,
      this.hastaAdi,
      this.hastaSoyadi});

  ActiveAppointment.fromJson(Map<String, dynamic> json) {
    doktorTCKN = json['doktorTCKN'];
    hastaTCKN = json['hastaTCKN'];
    randId = json['randId'];
    randevuTarihi = json['randevuTarihi'];
    doktorAdi = json['doktorAdi'];
    hastaAdi = json['hastaAdi'];
    doktorSoyadi = json['doktorSoyadi'];
    hastaSoyadi = json['hastaSoyadi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doktorTCKN'] = this.doktorTCKN;
    data['hastaTCKN'] = this.hastaTCKN;
    data['randId'] = this.randId;
    data['randevuTarihi'] = this.randevuTarihi;
    data['doktorAdi'] = this.doktorAdi;
    data['hastaAdi'] = this.hastaAdi;
    data['doktorSoyadi'] = this.doktorSoyadi;
    data['hastaSoyadi'] = this.hastaSoyadi;
    return data;
  }

  ActiveAppointment.fromMap(Map<String, dynamic> map, {this.reference})
      : doktorTCKN = map["doktorTCKN"],
        hastaTCKN = map["hastaTCKN"],
        randId = map["randId"],
        randevuTarihi = map["randevuTarihi"],
        doktorAdi = map["doktorAdi"],
        hastaAdi = map["hastaAdi"],
        doktorSoyadi = map["doktorSoyadi"],
        hastaSoyadi = map["hastaSoyadi"];

  ActiveAppointment.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
