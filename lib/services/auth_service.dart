import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:nw_chat_fer/global/enviroment.dart';
import 'package:nw_chat_fer/models/login_response.dart';
import 'package:nw_chat_fer/models/users.dart';

class AuthService with ChangeNotifier {
  User user;
  bool _isLoading = false;
  final _storage = FlutterSecureStorage();

  bool get isLoading => _isLoading;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<bool> login({String email, String password}) async {
    isLoading = true;
    final data = {
      'email': email,
      'password': password,
    };
    final resp = await http.post(
      '${Enviroment.apiURL}/login',
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    print(resp.body);
    isLoading = false;
    if (resp.statusCode == 200) {
      final LoginResponse loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.userDb;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signIn({String email, String password, String name}) async {
    isLoading = true;
    final data = {
      'email': email,
      'password': password,
      'name': name,
    };
    final resp = await http.post(
      '${Enviroment.apiURL}/login/new',
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    print(resp.body);
    isLoading = false;
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    await _deleteToken();
    return true;
  }

  Future<void> _saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  static Future<String> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> _deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }
}
