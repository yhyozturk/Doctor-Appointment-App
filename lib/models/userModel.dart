class Users {
  String kimlikNo;
  String adi;
  String soyadi;
  String dogumTarihi;
  String cinsiyet;
  String sifre;

  Users(
      {this.kimlikNo,
      this.adi,
      this.soyadi,
      this.dogumTarihi,
      this.cinsiyet,
      this.sifre});

  Users.fromJson(Map<String, dynamic> json) {
    kimlikNo = json['kimlikNo'];
    adi = json['Adi'];
    soyadi = json['Soyadi'];
    dogumTarihi = json['DogumTarihi'];
    cinsiyet = json['Cinsiyet'];
    sifre = json['Sifre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kimlikNo'] = this.kimlikNo;
    data['Adi'] = this.adi;
    data['Soyadi'] = this.soyadi;
    data['DogumTarihi'] = this.dogumTarihi;
    data['Cinsiyet'] = this.cinsiyet;
    data['Sifre'] = this.sifre;
    return data;
  }
}
