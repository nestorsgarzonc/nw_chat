import 'package:flutter/material.dart';
import 'package:nw_chat_fer/global/enviroment.dart';
import 'package:nw_chat_fer/models/messages_response.dart';
import 'package:nw_chat_fer/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:nw_chat_fer/services/auth_service.dart';

class ChatService with ChangeNotifier {
  User userFrom;

  Future<List<Message>> getChat(String userIdTo) async {
    final resp = await http.get(
      '${Enviroment.apiURL}/messages/$userIdTo',
      headers: {'Content-Type': 'application/json', 'x-token': await AuthService.getToken()},
    );
    final messagesResponse = messagesResponseFromJson(resp.body);
    return messagesResponse.messages;
  }
}
