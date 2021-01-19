import 'package:flutter/material.dart';
import 'package:nw_chat_fer/models/users.dart';
import 'package:nw_chat_fer/pages/chat_page.dart';
import 'package:nw_chat_fer/pages/login_page.dart';
import 'package:nw_chat_fer/services/auth_service.dart';
import 'package:nw_chat_fer/services/chat_service.dart';
import 'package:nw_chat_fer/services/socket_service.dart';
import 'package:nw_chat_fer/services/users_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  static const route = 'UsersPage';

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<User> users = [];

  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authProv = Provider.of<AuthService>(context);
    final SocketService socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(authProv.user.name, style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app_rounded, color: Colors.black),
          onPressed: () {
            //Logout
            socketService.disconnect();
            AuthService.deleteToken();
            Navigator.of(context).pushReplacementNamed(LoginPage.route);
          },
        ),
        actions: [
          Container(
            child: socketService.serverStatus == ServerStatus.Online
                ? Icon(Icons.check_circle, color: Colors.blue)
                : Icon(Icons.offline_bolt, color: Colors.red),
            margin: EdgeInsets.only(right: 10),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(),
        onLoading: _loadUsers,
        onRefresh: _loadUsers,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, i) => _UserTile(user: users[i]),
          itemCount: users.length,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _loadUsers() async {
    final usersProv = Provider.of<UserService>(context, listen: false);
    users = await usersProv.getUsers();
    setState(() {});
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.name),
        leading: CircleAvatar(
          child: Text(user.name.substring(0, 2), style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue[300],
        ),
        subtitle: Text(user.email),
        onTap: () => _handleOnTap(context),
        trailing: Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: user.online ? Colors.green[300] : Colors.red[300],
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }

  void _handleOnTap(BuildContext context) {
    final chatService = Provider.of<ChatService>(context, listen: false);
    chatService.userFrom = user;
    Navigator.pushNamed(context, ChatPage.route);
  }
}
