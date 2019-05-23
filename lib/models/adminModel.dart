import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  int id;
  String nickname;
  String password;
  var kapatilanSaatler = [];

  DocumentReference reference;

  Admin({this.id, this.nickname, this.password, this.kapatilanSaatler});

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    nickname = json['nickname'];
    password = json['password'];
    kapatilanSaatler = List.from(json['kapatilanSaatler']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['nickname'] = this.nickname;
    data['password'] = this.password;
    data['kapatilanSaatler'] = this.kapatilanSaatler;
    return data;
  }

  Admin.fromMap(Map<String, dynamic> map, {this.reference})
      : id = map["Id"],
        nickname = map["nickname"],
        password = map["password"],
        kapatilanSaatler = List.from(map["kapatilanSaatler"]);

  Admin.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
