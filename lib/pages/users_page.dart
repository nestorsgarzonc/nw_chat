import 'package:flutter/material.dart';
import 'package:nw_chat_fer/models/users.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  static const route = 'UsersPage';

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final users = [
    User(uid: '1', nombre: 'Karylin', email: 'kmackeague0@soundcloud.com', isOnline: false),
    User(uid: '2', nombre: 'Gearalt', email: 'gcullabine1@digg.com', isOnline: true),
    User(uid: '3', nombre: 'Eleen', email: 'epetrou2@telegraph.co.uk', isOnline: false),
    User(uid: '4', nombre: 'Minni', email: 'mfantini3@skype.com', isOnline: true),
    User(uid: '5', nombre: 'Toiboid', email: 'tferschke4@mapquest.com', isOnline: false),
    User(uid: '6', nombre: 'Elora', email: 'erodway5@businesswire.com', isOnline: true),
    User(uid: '7', nombre: 'Gibbie', email: 'galelsandrovich6@msu.edu', isOnline: true),
    User(uid: '8', nombre: 'Renee', email: 'rhathorn7@homestead.com', isOnline: false),
    User(uid: '9', nombre: 'Nicolette', email: 'nhuckell8@reddit.com', isOnline: false),
    User(uid: '10', nombre: 'Adrianna', email: 'ajohananoff9@ebay.com', isOnline: false),
    User(uid: '11', nombre: 'Rene', email: 'rcassiea@comsenz.com', isOnline: false),
    User(uid: '12', nombre: 'Elsinore', email: 'ecammishb@creativecommons.org', isOnline: true),
    User(uid: '13', nombre: 'Amalea', email: 'amulqueenc@rambler.ru', isOnline: true),
    User(uid: '14', nombre: 'Carmon', email: 'cmckombd@wix.com', isOnline: false),
    User(uid: '15', nombre: 'Nicola', email: 'npughsleye@cpanel.net', isOnline: false),
    User(uid: '16', nombre: 'Ryun', email: 'ralessandruccif@zdnet.com', isOnline: true),
    User(uid: '17', nombre: 'Perry', email: 'pbarlthropg@google.com.au', isOnline: true),
    User(uid: '18', nombre: 'Kevan', email: 'kpactath@va.gov', isOnline: true),
    User(uid: '19', nombre: 'Christophe', email: 'cbecki@mlb.com', isOnline: false),
    User(uid: '20', nombre: 'Stephie', email: 'slambournej@oakley.com', isOnline: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Username', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app_rounded, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          Container(
            child: Icon(Icons.check_circle, color: Colors.blue),
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
      title: Text(user.nombre),
      leading: CircleAvatar(
        child: Text(user.nombre.substring(0, 2)),
      ),
      trailing: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: user.isOnline ? Colors.green[300] : Colors.red[300],
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
