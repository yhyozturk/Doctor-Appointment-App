import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/models/userModel.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:fast_turtle_v2/models/adminModel.dart';
class AddService
{
  void saveUser(User user )
  {
       Firestore.instance.collection('tblKullanici').document().setData({
         'ad': user.adi,
         'soyad': user.soyadi,
          'kimlikNo': user.kimlikNo,
          'cinsiyet': user.cinsiyet,
          'dogumTarihi': user.dogumTarihi,
          'dogumYeri': user.dogumYeri,
          'sifre': user.sifre
        });
  }
  void saveDoktor(Doktor doktor)
  {
      Firestore.instance.collection("tblDoktor").document().setData({
        'ad':doktor.adi,
        'bolumId':doktor.bolumId,
        'hastaneId':doktor.hastaneId,
        'kimlikNo':doktor.kimlikNo,
        'sifre':doktor.sifre,
        'soyad':doktor.soyadi
      });
  }
  void saveAdmin(Admin admin){
    Firestore.instance.collection("tblAdmin").document().setData({
      'Id':admin.id,
      'nicname':admin.nickname,
      'password':admin.password
    });
  }
}