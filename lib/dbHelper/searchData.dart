import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:fast_turtle_v2/models/passiveAppoModel.dart';

class SearchService {
  searchById(String gelenId, String gelenPassword, int formKey) {
    if (formKey == 0) {
      return Firestore.instance
          .collection('tblKullanici')
          .where('kimlikNo', isEqualTo: gelenId)
          .where('sifre', isEqualTo: gelenPassword)
          .getDocuments();
    } else if (formKey == 1) {
      return Firestore.instance
          .collection('tblDoktor')
          .where('kimlikNo', isEqualTo: gelenId)
          .where('sifre', isEqualTo: gelenPassword)
          .getDocuments();
    } else if (formKey == 2) {
      return Firestore.instance
          .collection('tblAdmin')
          .where('nickname', isEqualTo: gelenId)
          .where('password', isEqualTo: gelenPassword)
          .getDocuments();
    }
  }

  searchByPassword(String gelenSifre, int formKey) {
    if (formKey == 0) {
      return Firestore.instance
          .collection('tblKullanici')
          .where('sifre', isEqualTo: gelenSifre)
          .getDocuments();
    } else if (formKey == 1) {
      return Firestore.instance
          .collection('tblDoktor')
          .where('sifre', isEqualTo: gelenSifre)
          .getDocuments();
    } else if (formKey == 2) {
      return Firestore.instance
          .collection('tblAdmin')
          .where('sifre', isEqualTo: gelenSifre)
          .getDocuments();
    }
  }

  searchHospitalByName(String value) {
    return Firestore.instance
        .collection("tblHastane")
        .where('hastaneAdi', isEqualTo: value)
        .getDocuments();
  }

  searchHospitalById(int value) {
    return Firestore.instance
        .collection("tblHastane")
        .where('hastaneId', isEqualTo: value)
        .getDocuments();
  }

  searchSectionById(int value) {
    return Firestore.instance
        .collection("tblBolum")
        .where('bolumId', isEqualTo: value)
        .getDocuments();
  }

  searchSectionsByHospitalId(int hospitalId) {
    return Firestore.instance
        .collection("tblBolum")
        .where('hastaneId', isEqualTo: hospitalId)
        .getDocuments();
  }

  searchSectionByHospitalIdAndSectionName(int hospitalId, String sectionName) {
    return Firestore.instance
        .collection("tblBolum")
        .where('hastaneId', isEqualTo: hospitalId)
        .where('bolumAdi', isEqualTo: sectionName)
        .getDocuments();
  }

  searchDoctorAppointment(Doktor doktor, String tarih) {
    return Firestore.instance
        .collection("tblAktifRandevu")
        .where('doktorTCKN', isEqualTo: doktor.kimlikNo)
        .where('randevuTarihi', isEqualTo: tarih)
        .getDocuments();
  }

  searchDoctorById(String kimlikNo) {
    return Firestore.instance
        .collection("tblDoktor")
        .where('kimlikNo', isEqualTo: kimlikNo)
        .getDocuments();
  }

  searchUserById(String kimlikNo) {
    return Firestore.instance
        .collection("tblKullanici")
        .where('kimlikNo', isEqualTo: kimlikNo)
        .getDocuments();
  }

  getHospitals() {
    return Firestore.instance.collection("tblHastane").getDocuments();
  }

  getSections() {
    return Firestore.instance.collection("tblBolum").getDocuments();
  }

  getLastSectionId() {
    return Firestore.instance
        .collection("tblBolum")
        .orderBy("bolumId", descending: true)
        .getDocuments();
  }

  getLastHospitalId() {
    return Firestore.instance
        .collection("tblHastane")
        .orderBy("hastaneId", descending: true)
        .getDocuments();
  }

  getDoctors() {
    return Firestore.instance.collection("tblDoktor").getDocuments();
  }

  getPastAppointments() {
    return Firestore.instance.collection("tblRandevuGecmisi").getDocuments();
  }

  searchPastAppointmentsByHastaTCKN(String tckn) {
    return Firestore.instance
        .collection("tblRandevuGecmisi")
        .where('hastaTCKN', isEqualTo: tckn)
        .getDocuments();
  }

  searchActiveAppointmentsByHastaTCKN(String tckn) {
    return Firestore.instance
        .collection("tblAktifRandevu")
        .where('hastaTCKN', isEqualTo: tckn)
        .getDocuments();
  }

  searchActiveAppointmentsWithHastaTCKNAndDoctorTCKN(
      String hastaTCKN, String doktorTCKN) {
    return Firestore.instance
        .collection("tblAktifRandevu")
        .where('hastaTCKN', isEqualTo: hastaTCKN)
        .where('doktorTCKN', isEqualTo: doktorTCKN)
        .getDocuments();
  }

  searchDocOnUserFavList(PassAppointment rand) {
    return Firestore.instance
        .collection("tblFavoriler")
        .where('hastaTCKN', isEqualTo: rand.hastaTCKN)
        .where('doktorTCKN', isEqualTo: rand.doktorTCKN)
        .getDocuments();
  }
}
