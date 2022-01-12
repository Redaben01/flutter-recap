import 'package:flutter/foundation.dart';

class UserModel {
  final String uid;
  final String email;
  final String token;

  UserModel({
    @required this.uid,
    @required this.email,
    @required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': this.uid,
        'token': this.token,
      };
}
