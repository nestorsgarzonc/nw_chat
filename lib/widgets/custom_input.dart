import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key key,
    @required this.label,
    @required this.icon,
    @required this.textController,
    this.isPassword = false,
    this.keybardType,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final bool isPassword;
  final TextEditingController textController;
  final TextInputType keybardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.grey[300], offset: Offset(0, 5), blurRadius: 5),
        ],
      ),
      child: TextFormField(
        controller: textController,
        obscureText: isPassword,
        keyboardType: keybardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon),
          hintText: label,
        ),
      ),
    );
  }
}
