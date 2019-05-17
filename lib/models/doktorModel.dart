import 'package:cloud_firestore/cloud_firestore.dart';

class Doktor {
  String kimlikNo;
  String adi;
  String soyadi;
  String sifre;
  int bolumId;
  int hastaneId;
  var randevular = [];

  DocumentReference reference;

  Doktor({
    this.kimlikNo,
    this.adi,
    this.soyadi,
    this.sifre,
    this.bolumId,
    this.hastaneId,
    this.randevular
  });

  Doktor.fromJson(Map<String, dynamic> json) {
    kimlikNo = json['kimlikNo'];
    adi = json['ad'];
    soyadi = json['soyad'];
    sifre = json['sifre'];
    bolumId = json['bolumId'];
    hastaneId = json['hastaneId'];
    randevular = json['randevular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kimlikNo'] = this.kimlikNo;
    data['ad'] = this.adi;
    data['soyad'] = this.soyadi;
    data['sifre'] = this.sifre;
    data['bolumId'] = this.bolumId;
    data['hastaneId'] = this.hastaneId;
    data['randevular'] = this.randevular;
    return data;
  }

  Doktor.fromMap(Map<String, dynamic> map, {this.reference})
      : kimlikNo = map["kimlikNo"],
        sifre = map["sifre"],
        adi = map["ad"],
        soyadi = map["soyad"],
        bolumId = map["bolumId"],
        hastaneId = map["hastaneId"],
        randevular =List.from( map["randevular"]);
        

  Doktor.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
