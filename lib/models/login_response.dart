import 'dart:convert';

import 'package:nw_chat_fer/models/users.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.ok,
    this.message,
    this.userDb,
    this.token,
  });

  bool ok;
  String message;
  User userDb;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        message: json["message"],
        userDb: User.fromJson(json["userDB"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "userDB": userDb.toJson(),
        "token": token,
      };
}
