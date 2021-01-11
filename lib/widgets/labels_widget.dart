import 'package:flutter/material.dart';

class LabelsWidget extends StatelessWidget {
  const LabelsWidget({
    Key key,
    @required this.route,
    @required this.questionText,
    @required this.actionText,
  }) : super(key: key);

  final String route;
  final String questionText;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(questionText, style: TextStyle(color: Colors.black45)),
        TextButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed(route),
          child: Text(
            actionText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[600]),
          ),
        ),
        SizedBox(height: 20),
        Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200)),
      ],
    );
  }
}
