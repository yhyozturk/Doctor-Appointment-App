import 'package:cloud_firestore/cloud_firestore.dart';

class PassAppointment {
  int kayitId;
  String doktorTCKN;
  String hastaTCKN;
  String islemTarihi;
  String doktorAdi;
  String hastaAdi;
  String doktorSoyadi;
  String hastaSoyadi;

  DocumentReference reference;

  PassAppointment(
      {this.kayitId,
      this.doktorTCKN,
      this.hastaTCKN,
      this.islemTarihi,
      this.doktorAdi,
      this.doktorSoyadi,
      this.hastaAdi,
      this.hastaSoyadi});

  PassAppointment.fromJson(Map<String, dynamic> json) {
    kayitId = json['kayitId'];
    doktorTCKN = json['doktorTCKN'];
    hastaTCKN = json['hastaTCKN'];
    islemTarihi = json['islemTarihi'];
    doktorAdi = json['doktorAdi'];
    hastaAdi = json['hastaAdi'];
    doktorSoyadi = json['doktorSoyadi'];
    hastaSoyadi = json['hastaSoyadi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kayitId'] = this.kayitId;
    data['doktorTCKN'] = this.doktorTCKN;
    data['hastaTCKN'] = this.hastaTCKN;
    data['islemTarihi'] = this.islemTarihi;
    data['doktorAdi'] = this.doktorAdi;
    data['hastaAdi'] = this.hastaAdi;
    data['doktorSoyadi'] = this.doktorSoyadi;
    data['hastaSoyadi'] = this.hastaSoyadi;
    return data;
  }

  PassAppointment.fromMap(Map<String, dynamic> map, {this.reference})
      : kayitId = map['kayitId'],
        doktorTCKN = map['doktorTCKN'],
        hastaTCKN = map['hastaTCKN'],
        islemTarihi = map['islemTarihi'],
        doktorAdi = map["doktorAdi"],
        hastaAdi = map["hastaAdi"],
        doktorSoyadi = map["doktorSoyadi"],
        hastaSoyadi = map["hastaSoyadi"];

  PassAppointment.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
