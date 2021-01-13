import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    Key key,
    @required this.text,
    @required this.uid,
    @required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(8);
    final bool isMine = uid == '123';

    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Align(
          alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 150,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Text(text, style: TextStyle(color: Colors.white)),
            decoration: BoxDecoration(
              color: isMine ? Colors.deepOrange : Colors.blue[400],
              borderRadius: isMine
                  ? BorderRadius.only(topLeft: radius, bottomLeft: radius)
                  : BorderRadius.only(topRight: radius, bottomRight: radius),
            ),
          ),
        ),
      ),
    );
  }
}
