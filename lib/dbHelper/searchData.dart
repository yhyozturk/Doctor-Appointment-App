import 'package:cloud_firestore/cloud_firestore.dart';


class SearchService {
  
  searchById(String gelenId){
    return Firestore.instance.collection('tblKullanici').where('kimlikNo', isEqualTo: gelenId).getDocuments();
  }
}