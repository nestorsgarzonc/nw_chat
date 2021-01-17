import 'package:flutter/material.dart';
import 'package:nw_chat_fer/pages/loading_page.dart';
import 'package:nw_chat_fer/services/auth_service.dart';
import 'package:nw_chat_fer/services/socket_service.dart';
import 'package:provider/provider.dart';

import 'routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthService()),
        ChangeNotifierProvider(create: (ctx) => SocketService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        routes: mapRoutes,
        initialRoute: LoadingPage.route,
        theme: ThemeData(scaffoldBackgroundColor: Color(0xFFF2F2F2)),
      ),
    );
  }
}
