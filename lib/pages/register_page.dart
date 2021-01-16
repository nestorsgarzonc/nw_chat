import 'package:flutter/material.dart';
import 'package:nw_chat_fer/helpers/show_alert.dart';
import 'package:nw_chat_fer/pages/login_page.dart';
import 'package:nw_chat_fer/services/auth_service.dart';
import 'package:nw_chat_fer/widgets/custom_input.dart';
import 'package:nw_chat_fer/widgets/icon_widget.dart';
import 'package:nw_chat_fer/widgets/labels_widget.dart';
import 'package:nw_chat_fer/widgets/large_button.dart';
import 'package:provider/provider.dart';

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
          Provider.of<AuthService>(context).isLoading
              ? Center(child: CircularProgressIndicator())
              : LargeButton(
                  text: 'Registrarme',
                  onPressed: _handleRegister,
                ),
        ],
      ),
    );
  }

  Future<void> _handleRegister() async {
    final bool res = await Provider.of<AuthService>(context, listen: false).signIn(
      email: _emailController.text.trim(),
      name: _nameController.text.trim(),
      password: _passwordController.text.trim(),
    );
    if (res) {
      await showAlert(
        context: context,
        subtitle: 'Usuario creado correctamente, inicia sesion con tu cuenta',
        title: 'Felicitaciones',
      );
      Navigator.of(context).pushReplacementNamed(LoginPage.route);
    } else {
      await showAlert(
        context: context,
        subtitle: 'Ha ocurrido un error, verifica los datos ingresados',
        title: 'Oops',
      );
    }
  }
}
