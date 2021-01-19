// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromJson(jsonString);

import 'dart:convert';
import 'package:nw_chat_fer/models/users.dart';

UsersResponse usersResponseFromJson(String str) => UsersResponse.fromJson(json.decode(str));
String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
  UsersResponse({
    this.ok,
    this.message,
    this.users,
    this.from,
  });

  bool ok;
  String message;
  List<User> users;
  int from;

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        ok: json["ok"],
        message: json["message"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        from: json["from"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "from": from,
      };
}
