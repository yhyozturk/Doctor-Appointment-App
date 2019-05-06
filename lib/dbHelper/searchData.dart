import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchById(String gelenId, int formKey) {
    if (formKey == 0) {
      return Firestore.instance
          .collection('tblKullanici')
          .where('kimlikNo', isEqualTo: gelenId)
          .getDocuments();
    } else if (formKey == 1) {
      return Firestore.instance
          .collection('tblDoktor')
          .where('kimlikNo', isEqualTo: gelenId)
          .getDocuments();
    } else if (formKey == 2) {
      return Firestore.instance
          .collection('tblAdmin')
          .where('nickname', isEqualTo: gelenId)
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

  searchSectionsByHospitalId(int hospitalId) {
    return Firestore.instance
        .collection("tblBolum")
        .where('hastaneId', isEqualTo: hospitalId)
        .getDocuments();
  }

  getHospitals() {
    return Firestore.instance.collection("tblHastane").getDocuments();
  }

  getSections() {
    return Firestore.instance.collection("tblBolum").getDocuments();
  }

  getDoctors() {
    return Firestore.instance.collection("tblDoktor").getDocuments();
  }
}
