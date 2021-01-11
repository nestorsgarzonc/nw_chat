import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({Key key, this.onPressed, @required this.text}) : super(key: key);

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.white)),
        color: Colors.blueAccent,
        shape: StadiumBorder(),
      ),
    );
  }
}
