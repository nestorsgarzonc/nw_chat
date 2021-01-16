import 'package:flutter/material.dart';
import 'package:nw_chat_fer/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  static const route = 'ChatPage';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final controller = TextEditingController();

  final focusNode = FocusNode();

  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 2,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(child: Text('SG'), backgroundColor: Colors.blue[200]),
            SizedBox(width: 10),
            Text(
              'Sebastian Garzon',
              style: TextStyle(color: Colors.black54, fontSize: 18),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _messages.length,
              reverse: true,
              itemBuilder: (context, index) => _messages[index],
            ),
          ),
          Divider(height: 1),
          _InputChat(
            focusNode: focusNode,
            controller: controller,
            onChange: (String e) {},
            onSubmitted: handleSubmit,
            onSendMessage: () => handleSubmit(controller.text),
          )
        ],
      ),
    );
  }

  void handleSubmit(String text) {
    if (text.trim().isEmpty) return;
    final newMessage = ChatMessage(
      text: text,
      uid: '123',
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
      ),
    );
    newMessage.animationController.forward();
    _messages.insert(0, newMessage);
    setState(() {});
    controller.clear();
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    //TODO: clean socket
    _messages.forEach((e) => e.animationController.dispose());
    super.dispose();
  }
}

class _InputChat extends StatelessWidget {
  const _InputChat({
    Key key,
    @required this.controller,
    @required this.onSubmitted,
    @required this.onChange,
    @required this.focusNode,
    @required this.onSendMessage,
  }) : super(key: key);

  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onChange;
  final FocusNode focusNode;
  final VoidCallback onSendMessage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: 70,
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: controller,
                onSubmitted: onSubmitted,
                onChanged: onChange,
                decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
                focusNode: focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: CircleAvatar(
                backgroundColor: Colors.blue[400],
                child: IconButton(
                  icon: Icon(Icons.send, color: Colors.white),
                  onPressed: onSendMessage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
