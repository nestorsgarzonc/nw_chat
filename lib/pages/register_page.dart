import 'package:flutter/material.dart';
import 'package:nw_chat_fer/pages/login_page.dart';
import 'package:nw_chat_fer/widgets/custom_input.dart';
import 'package:nw_chat_fer/widgets/icon_widget.dart';
import 'package:nw_chat_fer/widgets/labels_widget.dart';
import 'package:nw_chat_fer/widgets/large_button.dart';

class RegisterPage extends StatelessWidget {
  static const route = 'RegisterPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconWidget(),
            SizedBox(height: 20),
            _Form(),
            SizedBox(height: 20),
            LabelsWidget(
              route: LoginPage.route,
              actionText: 'Inicia sesion ahora!',
              questionText: 'Ya tienes cuenta?',
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity_rounded,
            label: 'Nombre',
            keybardType: TextInputType.emailAddress,
            textController: _nameController,
          ),
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
            text: 'Registrarme',
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
