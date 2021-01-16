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
    User(uid: '1', name: 'Karylin', email: 'kmackeague0@soundcloud.com', online: false),
    User(uid: '2', name: 'Gearalt', email: 'gcullabine1@digg.com', online: true),
    User(uid: '3', name: 'Eleen', email: 'epetrou2@telegraph.co.uk', online: false),
    User(uid: '4', name: 'Minni', email: 'mfantini3@skype.com', online: true),
    User(uid: '5', name: 'Toiboid', email: 'tferschke4@mapquest.com', online: false),
    User(uid: '6', name: 'Elora', email: 'erodway5@businesswire.com', online: true),
    User(uid: '7', name: 'Gibbie', email: 'galelsandrovich6@msu.edu', online: true),
    User(uid: '8', name: 'Renee', email: 'rhathorn7@homestead.com', online: false),
    User(uid: '9', name: 'Nicolette', email: 'nhuckell8@reddit.com', online: false),
    User(uid: '10', name: 'Adrianna', email: 'ajohananoff9@ebay.com', online: false),
    User(uid: '11', name: 'Rene', email: 'rcassiea@comsenz.com', online: false),
    User(uid: '12', name: 'Elsinore', email: 'ecammishb@creativecommons.org', online: true),
    User(uid: '13', name: 'Amalea', email: 'amulqueenc@rambler.ru', online: true),
    User(uid: '14', name: 'Carmon', email: 'cmckombd@wix.com', online: false),
    User(uid: '15', name: 'Nicola', email: 'npughsleye@cpanel.net', online: false),
    User(uid: '16', name: 'Ryun', email: 'ralessandruccif@zdnet.com', online: true),
    User(uid: '17', name: 'Perry', email: 'pbarlthropg@google.com.au', online: true),
    User(uid: '18', name: 'Kevan', email: 'kpactath@va.gov', online: true),
    User(uid: '19', name: 'Christophe', email: 'cbecki@mlb.com', online: false),
    User(uid: '20', name: 'Stephie', email: 'slambournej@oakley.com', online: true),
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
