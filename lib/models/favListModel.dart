import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteList {
  String doktorTCKN;
  String doktorAdi;
  String doktorSoyadi;
  String hastaTCKN;
  String hastaAdi;
  String hastaSoyadi;
  DocumentReference reference;

  FavoriteList(
      {this.doktorTCKN,
      this.hastaTCKN,
      this.doktorAdi,
      this.doktorSoyadi,
      this.hastaAdi,
      this.hastaSoyadi});

  FavoriteList.fromJson(Map<String, dynamic> json) {
    doktorTCKN = json['doktorTCKN'];
    hastaTCKN = json['hastaTCKN'];
    doktorAdi = json['doktorAdi'];
    hastaAdi = json['hastaAdi'];
    doktorSoyadi = json['doktorSoyadi'];
    hastaSoyadi = json['hastaSoyadi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doktorTCKN'] = this.doktorTCKN;
    data['hastaTCKN'] = this.hastaTCKN;
    data['doktorAdi'] = this.doktorAdi;
    data['hastaAdi'] = this.hastaAdi;
    data['doktorSoyadi'] = this.doktorSoyadi;
    data['hastaSoyadi'] = this.hastaSoyadi;
    return data;
  }

  FavoriteList.fromMap(Map<String, dynamic> map, {this.reference})
      : doktorTCKN = map["doktorTCKN"],
        hastaTCKN = map["hastaTCKN"],
        doktorAdi = map["doktorAdi"],
        hastaAdi = map["hastaAdi"],
        doktorSoyadi = map["doktorSoyadi"],
        hastaSoyadi = map["hastaSoyadi"];

  FavoriteList.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
