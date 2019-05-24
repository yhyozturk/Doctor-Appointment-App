import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String kimlikNo;
  String adi;
  String soyadi;
  String sifre;
  String dogumTarihi;
  String cinsiyet;
  String dogumYeri;

  DocumentReference reference;

  User(
      {this.kimlikNo,
      this.adi,
      this.soyadi,
      this.sifre,
      this.dogumTarihi,
      this.cinsiyet,
      this.dogumYeri});

  User.fromJson(Map<String, dynamic> json) {
    kimlikNo = json['kimlikNo'];
    adi = json['adi'];
    soyadi = json['soyadi'];
    dogumTarihi = json['dogumTarihi'];
    cinsiyet = json['cinsiyet'];
    sifre = json['sifre'];
    dogumYeri = json["dogumYeri"];
  }

  User.fromMap(Map<String, dynamic> map, {this.reference})
      : kimlikNo = map["kimlikNo"],
        sifre = map["sifre"],
        adi = map["ad"],
        soyadi = map["soyad"],
        dogumYeri = map["dogumYeri"],
        dogumTarihi = map["dogumTarihi"],
        cinsiyet = map["cinsiyet"];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kimlikNo'] = this.kimlikNo;
    data['adi'] = this.adi;
    data['soyadi'] = this.soyadi;
    data['dogumTarihi'] = this.dogumTarihi;
    data['cinsiyet'] = this.cinsiyet;
    data['sifre'] = this.sifre;
    data['dogumYeri'] = this.dogumYeri;
    return data;
  }
}
