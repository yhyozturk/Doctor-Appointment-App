class Doktor {
  String kimlikNo;
  String adi;
  String soyadi;
  String sifre;
  int bolumId;
  int hastaneId;

  Doktor(
      {this.kimlikNo,
      this.adi,
      this.soyadi,
      this.sifre,
      this.bolumId,
      this.hastaneId});

  Doktor.fromJson(Map<String, dynamic> json) {
    kimlikNo = json['kimlikNo'];
    adi = json['adi'];
    soyadi = json['soyadi'];
    sifre = json['sifre'];
    bolumId = json['bolumId'];
    hastaneId = json['hastaneId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kimlikNo'] = this.kimlikNo;
    data['adi'] = this.adi;
    data['soyadi'] = this.soyadi;
    data['sifre'] = this.sifre;
    data['bolumId'] = this.bolumId;
    data['hastaneId'] = this.hastaneId;
    return data;
  }
}
