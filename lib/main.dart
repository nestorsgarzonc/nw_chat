import 'package:flutter/material.dart';
import 'package:nw_chat_fer/pages/chat_page.dart';
import 'package:nw_chat_fer/pages/users_page.dart';
import 'pages/login_page.dart';
import 'routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: mapRoutes,
      initialRoute: ChatPage.route,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFF2F2F2)),
    );
  }
}
