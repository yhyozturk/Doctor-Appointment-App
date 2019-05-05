import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/dbHelper/searchData.dart';

class ValidationMixin {
  String validateTCNo(String value) {
    if (value.length != 11) {
      return "T.C. Kimlik Numarası 11 hane olmalıdır";
    }
    return null;
  }

  String validateFirstName(String value) {
    if (value.length < 2) {
      return "İsim en az iki karakter olmalıdır";
    }
    return null;
  }

  String validateLastName(String value) {
    if (value.length < 2) {
      return "Soyadı en az iki karakter olmalıdır";
    }
    return null;
  }

  String validateAdmin(String value) {
    if (value != "admin") {
      return "Hatalı yada eksik bilgi girdiniz";
    }
    return null;
  }

  
  var user;
  QuerySnapshot ds;
  var veri;
  DataSearchState dataSearchState = DataSearchState();

  String validateTCNoforLogin(String kimlikNumarasi) {
    // searchById(kimlikNumarasi).then((QuerySnapshot docs) {
    //    user = docs.documents[0].data;
    // } );
    // if (user['kimlikNo'] != kimlikNumarasi) {
    //   return "Eksik yada hatalı bilgi girdiniz";
    // } else {
    //   return null;
    // }
    // veri = dataSearchState.searchById(context);
    if (kimlikNumarasi != veri) {
      return "Eksik yada hatalı bilgi girdiniz";
    } else {
      return null;
    }
  }

  String validateSifreforLogin(String value) {
    if (veri != value) {
      return "Hatalı yada eksik şifre girdiniz";
    }
    return null;
  }

  // // searchbyid(string kimliknumarasi) {
  // //   return streambuilder(
  // //     stream: firestore.instance.collection('tblkullanici').snapshots(),
  // //     builder: (context),
  // //   );
  // // }

  searchByPassword(String password) {
    return Firestore.instance
        .collection('tblKullanici')
        .where('sifre', isEqualTo: password)
        .getDocuments();
  }
}
