import 'package:flutter/material.dart';
import 'package:nw_chat_fer/global/enviroment.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    // Dart client
    this._socket = IO.io(
      Enviroment.socketURL,
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      print('Connected');
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      print('Disconnected');
      notifyListeners();
    });
  }
}
