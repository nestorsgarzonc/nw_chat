import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: 'IconWidger',
          child: Icon(
            Icons.chat_bubble_outline_rounded,
            color: Colors.blue[400],
            size: 220,
          ),
        ),
        Text('NW Chat', style: TextStyle(fontSize: 30)),
      ],
    );
  }
}
