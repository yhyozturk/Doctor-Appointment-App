import 'package:cloud_firestore/cloud_firestore.dart';

class Doktor {
  String kimlikNo;
  String adi;
  String soyadi;
  String sifre;
  int bolumId;
  int hastaneId;
  var randevular = [];
  int favoriSayaci;
  String dogumTarihi;
  String cinsiyet;
  String dogumYeri;

  DocumentReference reference;

  Doktor(
      {this.kimlikNo,
      this.adi,
      this.soyadi,
      this.sifre,
      this.bolumId,
      this.hastaneId,
      this.randevular,
      this.favoriSayaci,
      this.dogumTarihi,
      this.cinsiyet,
      this.dogumYeri});

  Doktor.fromJson(Map<String, dynamic> json) {
    kimlikNo = json['kimlikNo'];
    adi = json['ad'];
    soyadi = json['soyad'];
    sifre = json['sifre'];
    bolumId = json['bolumId'];
    hastaneId = json['hastaneId'];
    randevular = List.from(json['randevular']);
    favoriSayaci = json['favoriSayaci'];
    dogumTarihi = json['dogumTarihi'];
    cinsiyet = json['cinsiyet'];
    dogumYeri = json["dogumYeri"];
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
    data['favoriSayaci'] = this.favoriSayaci;
    data['dogumTarihi'] = this.dogumTarihi;
    data['cinsiyet'] = this.cinsiyet;
    data['dogumYeri'] = this.dogumYeri;
    return data;
  }

  Doktor.fromMap(Map<String, dynamic> map, {this.reference})
      : kimlikNo = map["kimlikNo"],
        sifre = map["sifre"],
        adi = map["ad"],
        soyadi = map["soyad"],
        bolumId = map["bolumId"],
        hastaneId = map["hastaneId"],
        randevular = List.from(map["randevular"]),
        favoriSayaci = map["favoriSayaci"],
        dogumYeri = map["dogumYeri"],
        dogumTarihi = map["dogumTarihi"],
        cinsiyet = map["cinsiyet"];

  Doktor.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
