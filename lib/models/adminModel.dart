import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  int id;
  String nickname;
  String password;

  DocumentReference reference;

  Admin({this.id, this.nickname, this.password});

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    nickname = json['nickname'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['nickname'] = this.nickname;
    data['password'] = this.password;
    return data;
  }

  Admin.fromMap(Map<String, dynamic> map, {this.reference})
      : id = map["Id"],
        nickname = map["nickname"],
        password = map["password"];

  Admin.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
