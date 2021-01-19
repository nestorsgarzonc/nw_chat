import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nw_chat_fer/global/enviroment.dart';
import 'package:nw_chat_fer/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:nw_chat_fer/models/users_response.dart';
import 'package:nw_chat_fer/services/auth_service.dart';

class UserService extends ChangeNotifier {
  Future<List<User>> getUsers() async {
    try {
      final resp = await http.get(
        '${Enviroment.apiURL}/users',
        headers: {'Content-Type': 'application/json', 'x-token': await AuthService.getToken()},
      );
      List<User> usersResp = usersResponseFromJson(resp.body).users;
      return usersResp;
    } catch (e) {
      return null;
    }
  }
}
