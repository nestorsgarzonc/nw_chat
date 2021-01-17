import 'package:flutter/material.dart';
import 'package:nw_chat_fer/pages/login_page.dart';
import 'package:nw_chat_fer/pages/users_page.dart';
import 'package:nw_chat_fer/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  static const route = 'LoadingPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<AuthService>(context).isLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data) {
              return UsersPage();
            }
            return LoginPage();
          }
          return Center(child: Text('Animation ;)'));
        },
      ),
    );
  }
}
