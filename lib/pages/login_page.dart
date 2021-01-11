import 'package:flutter/material.dart';
import 'package:nw_chat_fer/pages/register_page.dart';
import 'package:nw_chat_fer/widgets/custom_input.dart';
import 'package:nw_chat_fer/widgets/icon_widget.dart';
import 'package:nw_chat_fer/widgets/labels_widget.dart';
import 'package:nw_chat_fer/widgets/large_button.dart';

class LoginPage extends StatelessWidget {
  static const route = 'LoginPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconWidget(),
            SizedBox(height: 60),
            _Form(),
            SizedBox(height: 30),
            LabelsWidget(
              route: RegisterPage.route,
              actionText: 'Crea una cuenta ahora!',
              questionText: 'No tienes cuenta?',
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            label: 'Email',
            keybardType: TextInputType.emailAddress,
            textController: _emailController,
          ),
          CustomInput(
            icon: Icons.lock,
            label: 'Password',
            isPassword: true,
            textController: _passwordController,
            keybardType: TextInputType.visiblePassword,
          ),
          SizedBox(height: 20),
          LargeButton(
            text: 'Ingresar',
            onPressed: () {
              print('asd');
              print(_emailController.text);
            },
          )
        ],
      ),
    );
  }
}
