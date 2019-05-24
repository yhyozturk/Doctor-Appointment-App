import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';
import 'package:fast_turtle_v2/models/activeAppointmentModel.dart';
import 'package:fast_turtle_v2/models/passiveAppoModel.dart';
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
    var randevular = [];
    Firestore.instance.collection('tblDoktor').document().setData({
      'kimlikNo': dr.kimlikNo,
      'ad': dr.adi,
      'soyad': dr.soyadi,
      'sifre': dr.sifre,
      'bolumId': bolumu.bolumId,
      'hastaneId': hastanesi.hastaneId,
      'cinsiyet': dr.cinsiyet,
      'dogumTarihi': dr.dogumTarihi,
      'dogumYeri': dr.dogumYeri,
      'favoriSayaci' : 0,
      'randevular' : randevular
    });
  }

  void addActiveAppointment(Doktor dr, User user, String tarih) {
    Firestore.instance.collection('tblAktifRandevu').document().setData({
      'doktorTCKN': dr.kimlikNo,
      'hastaTCKN': user.kimlikNo,
      'randevuTarihi': tarih,
      'doktorAdi': dr.adi,
      'doktorSoyadi': dr.soyadi,
      'hastaAdi': user.adi,
      'hastaSoyadi': user.soyadi
    });
  }

  void addDoctorToUserFavList(PassAppointment rand) {
    Firestore.instance.collection('tblFavoriler').document().setData({
      'doktorTCKN': rand.doktorTCKN,
      'hastaTCKN': rand.hastaTCKN,
      'doktorAdi': rand.doktorAdi,
      'doktorSoyadi': rand.doktorSoyadi,
      'hastaAdi': rand.hastaAdi,
      'hastaSoyadi': rand.hastaSoyadi
    });
  }

  void addPastAppointment(ActiveAppointment randevu) {
    Firestore.instance.collection('tblRandevuGecmisi').document().setData({
      'doktorTCKN': randevu.doktorTCKN,
      'hastaTCKN': randevu.hastaTCKN,
      'islemTarihi': randevu.randevuTarihi,
      'doktorAdi': randevu.doktorAdi,
      'doktorSoyadi': randevu.doktorSoyadi,
      'hastaAdi': randevu.hastaAdi,
      'hastaSoyadi': randevu.hastaSoyadi
    });
  }

  addDoctorAppointment(Doktor doktor) {
    Firestore.instance
        .collection("tblDoktor")
        .document(doktor.reference.documentID)
        .setData({'randevular': doktor.randevular}, merge: true);
  }

  closeDoctorAppointment(Admin admin) {
    Firestore.instance
        .collection("tblAdmin")
        .document(admin.reference.documentID)
        .setData({'kapatilanSaatler': admin.kapatilanSaatler}, merge: true);
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
    SearchService().getLastHospitalId().then((QuerySnapshot docs) {
      Firestore.instance.collection("tblHastane").document().setData({
        'hastaneAdi': hastane.hastaneAdi,
        'hastaneId': docs.documents[0]['hastaneId'] + 1,
      });
    });

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
