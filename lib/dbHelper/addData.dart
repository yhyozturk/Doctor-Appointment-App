import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/models/sectionModel.dart';
import 'package:fast_turtle_v2/models/userModel.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:fast_turtle_v2/models/adminModel.dart';
import 'package:fast_turtle_v2/models/hospitalModel.dart';

class AddService {
  String saveUser(User user) {
    Firestore.instance.collection('tblKullanici').document().setData({
      'ad': user.adi,
      'soyad': user.soyadi,
      'kimlikNo': user.kimlikNo,
      'cinsiyet': user.cinsiyet,
      'dogumTarihi': user.dogumTarihi,
      'dogumYeri': user.dogumYeri,
      'sifre': user.sifre
    });
    return 'kullanıcı ekleme işlemi Tamamlandı';
  }

  void saveDoctor(Doktor dr, Section bolumu, Hospital hastanesi) {
    Firestore.instance.collection('tblDoktor').document().setData({
      'kimlikNo': dr.kimlikNo,
      'ad': dr.adi,
      'soyad': dr.soyadi,
      'sifre': dr.sifre,
      'bolumId': bolumu.bolumId,
      'hastaneId': hastanesi.hastaneId
    });
  }

  String saveAdmin(Admin admin) {
    Firestore.instance.collection("tblAdmin").document().setData({
      'Id': admin.id,
      'nicname': admin.nickname,
      'password': admin.password
    });
    return 'Admin ekleme işlem tamamlandı';
  }

  String saveHospital(Hospital hastane) {
    Firestore.instance.collection("tblHastane").document().setData(
        {'hastaneAdi': hastane.hastaneAdi, 'hastaneId': hastane.hastaneId});
    return 'Hastane kaydı tamamlandı';
  }

  String saveSection(Section bolum, Hospital hastane) {
    SearchService().getLastSectionId().then((QuerySnapshot docs) {
      Firestore.instance.collection("tblBolum").document().setData({
        "bolumAdi": bolum.bolumAdi,
        "bolumId": docs.documents[0]["bolumId"] + 1,
        "hastaneId": hastane.hastaneId
      });
    });
    return "Bölüm ekleme tamamlandı";
  }
}
