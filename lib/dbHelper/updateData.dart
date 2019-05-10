import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/models/sectionModel.dart';
import 'package:fast_turtle_v2/models/userModel.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:fast_turtle_v2/models/hospitalModel.dart';

class UpdateService {
  String updateUser(User user) {
    Firestore.instance
        .collection("tblKullanici")
        .document(user.reference.documentID)
        .updateData({'sifre': user.sifre.toString()});
    return "Güncelleme gerçekleştirildi";
  }

  String updateDoktor(Doktor doktor) {
    Firestore.instance
        .collection("tblDoktor")
        .document(doktor.reference.documentID)
        .updateData({
      'ad': doktor.adi,
      'sifre': doktor.sifre.toString(),
      'soyad': doktor.soyadi
    });
    return "Güncelleme gerçekleştirildi";
  }

  String updateHastane(Hospital hastane) {
    Firestore.instance
        .collection("tblHastane")
        .document(hastane.reference.documentID)
        .updateData({'hastaneAdi': hastane.hastaneAdi.toString()});
    return "Güncelleme gerçekleştirildi";
  }

  String updateSection(Section bolum) {
    Firestore.instance
        .collection("tblBolum")
        .document(bolum.reference.documentID)
        .updateData({'bolumAdi': bolum.bolumAdi.toString()});
    return "Güncelleme gerçekleştirildi";
  }
}
