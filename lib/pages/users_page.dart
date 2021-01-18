import 'package:flutter/material.dart';
import 'package:nw_chat_fer/models/users.dart';
import 'package:nw_chat_fer/pages/login_page.dart';
import 'package:nw_chat_fer/services/auth_service.dart';
import 'package:nw_chat_fer/services/socket_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  static const route = 'UsersPage';

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final users = [
    User(uid: '1', name: 'Karylin', email: 'kmackeague0@soundcloud.com', online: false),
    User(uid: '2', name: 'Gearalt', email: 'gcullabine1@digg.com', online: true),
    User(uid: '3', name: 'Eleen', email: 'epetrou2@telegraph.co.uk', online: false),
    User(uid: '16', name: 'Ryun', email: 'ralessandruccif@zdnet.com', online: true),
    User(uid: '17', name: 'Perry', email: 'pbarlthropg@google.com.au', online: true),
    User(uid: '18', name: 'Kevan', email: 'kpactath@va.gov', online: true),
  ];

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
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, i) => _UserTile(user: users[i]),
          separatorBuilder: (context, index) => Divider(),
          itemCount: users.length,
        ),
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
      ),
      trailing: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.green[300] : Colors.red[300],
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
