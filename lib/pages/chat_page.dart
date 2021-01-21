import 'package:flutter/material.dart';
import 'package:nw_chat_fer/models/messages_response.dart';
import 'package:nw_chat_fer/models/users.dart';
import 'package:nw_chat_fer/services/auth_service.dart';
import 'package:nw_chat_fer/services/chat_service.dart';
import 'package:nw_chat_fer/services/socket_service.dart';
import 'package:nw_chat_fer/widgets/chat_message.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  static const route = 'ChatPage';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  ChatService chatService;
  SocketService socketService;
  AuthService authService;
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);
    socketService.socket.on('personal-message', _listenMessages);
    loadHistory(chatService.userFrom.uid);
  }

  void loadHistory(String userIdTo) async {
    List<Message> messages = await chatService.getChat(userIdTo);
    messages.forEach((e) {
      final message = ChatMessage(
        text: e.message,
        uid: e.to,
        animationController: AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 200),
        ),
      );
      message.animationController.forward();
      _messages.add(message);
    });
    setState(() {});
  }

  void _listenMessages(dynamic data) {
    print('Has message: $data');
    ChatMessage message = ChatMessage(
      text: data['message'],
      uid: data['from'],
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
      ),
    );
    _messages.insert(0, message);
    message.animationController.forward();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final User userFrom = chatService.userFrom;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 2,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              child: Text(userFrom.name.substring(0, 2)),
              backgroundColor: Colors.blue[200],
            ),
            SizedBox(width: 10),
            Text(
              userFrom.name,
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
      uid: authService.user.uid,
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
    socketService.emit('personal-message', {
      'from': authService.user.uid,
      'to': chatService.userFrom.uid,
      'message': text,
    });
  }

  @override
  void dispose() {
    socketService.socket.off('personal-message');
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
