import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/models/sectionModel.dart';
import 'package:fast_turtle_v2/models/userModel.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:fast_turtle_v2/models/hospitalModel.dart';

class UpdateService {
  updateUser(User user) {
    Firestore.instance
        .collection("tblKullanici")
        .document(user.reference.documentID)
        .updateData({
      'sifre': user.sifre.toString(),
      'ad': user.adi,
      'soyad': user.soyadi
    });
  }

  // String updateUserFavList(String kimlikNo, String doktorAdSoyad) {
  //   User temp;
  //   SearchService().searchUserById(kimlikNo).then((QuerySnapshot docs) {
  //     temp = User.fromMap(docs.documents[0].data);
  //     temp.reference = docs.documents[0].reference;
  //     if (!temp.favoriDoktorlar.contains(doktorAdSoyad)) {
  //       temp.favoriDoktorlar.add(doktorAdSoyad);

  //       Firestore.instance
  //           .collection("tblKullanici")
  //           .document(temp.reference.documentID)
  //           .updateData({'favoriDoktorlar': temp.favoriDoktorlar});
  //     }
  //   });

  //   return "Güncelleme gerçekleştirildi";
  // }

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

  String updateDoktorFavCountPlus(String doktorNo) {
    Doktor doktor;
    SearchService().searchDoctorById(doktorNo).then((QuerySnapshot docs) {
      doktor = Doktor.fromMap(docs.documents[0].data);
      doktor.reference = docs.documents[0].reference;
      Firestore.instance
          .collection("tblDoktor")
          .document(doktor.reference.documentID)
          .updateData({'favoriSayaci': doktor.favoriSayaci + 1});
    });

    return "Güncelleme gerçekleştirildi";
  }

  String updateDoktorFavCountMinus(String doktorNo) {
    Doktor doktor;
    SearchService().searchDoctorById(doktorNo).then((QuerySnapshot docs) {
      doktor = Doktor.fromMap(docs.documents[0].data);
      doktor.reference = docs.documents[0].reference;
      Firestore.instance
          .collection("tblDoktor")
          .document(doktor.reference.documentID)
          .updateData({'favoriSayaci': doktor.favoriSayaci - 1});
    });

    return "Güncelleme gerçekleştirildi";
  }

  String updateDoctorAppointments(String kimlikNo, String islemTarihi) {
    Doktor temp;
    SearchService().searchDoctorById(kimlikNo).then((QuerySnapshot docs) {
      temp = Doktor.fromMap(docs.documents[0].data);
      temp.reference = docs.documents[0].reference;
      if (temp.randevular.contains(islemTarihi)) {
        temp.randevular.remove(islemTarihi);

        Firestore.instance
            .collection("tblDoktor")
            .document(temp.reference.documentID)
            .updateData({'randevular': temp.randevular});
      }
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
