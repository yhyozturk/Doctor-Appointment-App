import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/models/userModel.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';
import 'package:fast_turtle_v2/models/adminModel.dart';
import 'package:fast_turtle_v2/models/hospitalModel.dart';
class UpdateService{
String updateUser(User user){
  Firestore.instance
  .collection("tblKullanici")
  .document(user.reference.toString())
  .updateData({
    'sifre':user.sifre.toString()
  });
  return "Güncelleme gerçekleştirildi";
}
String updateDoktor(Doktor doktor){
  Firestore.instance.collection("tblDoktor")
  .document(doktor.reference.toString())
  .updateData({
    'hastaneId':doktor.hastaneId,
    'sifre':doktor.sifre.toString()
  });
  return "Güncelleme gerçekleştirildi";
}
String updateHastane(Hospital hastane){
  Firestore.instance.collection("tblHastane")
  .document(hastane.reference.toString())
  .updateData({
    'hastaneAdi':hastane.hastaneAdi.toString()
  });
  return "Güncelleme gerçekleştirildi";
}
}