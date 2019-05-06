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
}
