import 'package:flutter/material.dart';
import '../pages/chat_page.dart';
import '../pages/loading_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/users_page.dart';

final Map<String, WidgetBuilder> mapRoutes = {
  UsersPage.route: (ctx) => UsersPage(),
  ChatPage.route: (ctx) => ChatPage(),
  RegisterPage.route: (ctx) => RegisterPage(),
  LoginPage.route: (ctx) => LoginPage(),
  LoadingPage.route: (ctx) => LoadingPage(),
};
