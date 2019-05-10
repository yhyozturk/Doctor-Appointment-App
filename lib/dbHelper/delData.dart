import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_turtle_v2/models/activeAppointmentModel.dart';
import 'package:fast_turtle_v2/models/doktorModel.dart';

class DelService {
  ActiveAppointment activeAppointment = ActiveAppointment();

  // This method delete a doctor also her/his active appoit
  deleteDoctorbyTCKN(Doktor doktor) {
    Firestore.instance
        .collection("tblDoktor")
        .document(doktor.reference.documentID)
        .delete();
    Firestore.instance
        .collection("tblAktifRandevu")
        .where('doktorTCKN', isEqualTo: doktor.kimlikNo)
        .getDocuments()
        .then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        for (var i = 0; i < docs.documents.length; i++) {
          Firestore.instance
              .collection("tblAktifRandevu")
              .document(docs.documents[i].reference.documentID)
              .delete();
        }
      }
    });
  }
}
