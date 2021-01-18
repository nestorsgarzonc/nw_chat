import 'package:flutter/material.dart';
import 'package:nw_chat_fer/global/enviroment.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'auth_service.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  SocketService() {
    connect();
  }

  void connect() async {
    final token = await AuthService.getToken();
    _socket = IO.io(
      Enviroment.socketURL,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNew()
          .setExtraHeaders({'x-token': token})
          .build(),
    );

    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.Online;
      print('Connected');
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      print('Disconnected');
      notifyListeners();
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
