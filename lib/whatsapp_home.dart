import 'package:flutter/material.dart';
import 'package:pop/pages/call_screen.dart';
import 'package:pop/pages/camera_screen.dart';
import 'package:pop/pages/chat_screen.dart';
import 'package:pop/add_marker.dart';
import 'package:pop/pages/status_screen.dart';
import 'package:pop/pages/profile.dart';
import 'package:pop/pages/weather.dart';
import 'package:pop/pages/schemes_home.dart';
import 'package:pop/pages/market.dart';
import 'package:pop/request_select.dart';

//import 'package:pop/pages/weather.dart';

class WhatsAppHome extends StatefulWidget {
  final aadhar, email, name, state, rewards, age, sex, role, crops;
  WhatsAppHome(this.aadhar, this.email, this.name, this.state, this.rewards,
      this.age, this.sex, this.role, this.crops);
  // var cameras;
  // WhatsAppHome(this.cameras);

  @override
  _WhatsAppHomeState createState() => new _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String aadhar, email, name, state, age, sex, role, crops;
  int rewards;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 1, length: 3);
    aadhar = widget.aadhar;
    email = widget.email;
    rewards = widget.rewards;
    name = widget.name;
    state = widget.state;
    age = widget.age;
    sex = widget.sex;
    role = widget.role;
    crops = widget.crops;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("AgriConnect"),
          //centerTitle: true,
          elevation: 0.7,
          bottom: new TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              new Tab(text: "MARKET"),
              (role == "Farmer")
                  ? new Tab(text: "SCHEMES")
                  : Tab(text: "REQUESTS"),
              // new Tab(
              //   text: "LOCATE",
              // ),
              new Tab(
                text: "NEWS",
              ),
            ],
          ),
          // actions: <Widget>[
          //   new Icon(Icons.search),
          //   new Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 5.0),
          //   ),
          //   new Icon(Icons.more_vert)
          // ],
        ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: Text("$name"),
                accountEmail: Text("$email"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/img/login_logo.png'),
                  // child: Text(
                  //   "A",
                  //   style: TextStyle(fontSize: 30.0),
                  // ),
                ),
              ),
              new ListTile(
                title: Text("Your Account"),
                trailing: new Icon(Icons.person),
                onTap: () => {
                  Navigator.of(context).pop(),
                  Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new Profile(aadhar,
                          email, name, state, rewards, age, sex, role, crops),
                    ),
                  ),
                },
              ),
              new Divider(),
              new ListTile(
                title: Text("Weather"),
                trailing: new Icon(Icons.cloud),
                onTap: () => {
                  Navigator.of(context).pop(),
                  Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new WeatherApp(),
                    ),
                  ),
                },
              ),
              new Divider(),
              new ListTile(
                title: Text("Locate"),
                trailing: new Icon(
                  Icons.pin_drop,
                  // size: 30.0,
                ),
                onTap: () => {
                  Navigator.of(context).pop(),
                  (role == "Farmer")
                      ? Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new ListMap(aadhar),
                            //StatusScreen(),
                          ),
                        )
                      : Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new StatusScreen(),
                            //StatusScreen(),
                          ),
                        ),
                },
              ),
              (role != 'Farmer')
                  ? Column(
                      children: <Widget>[
                        new Divider(),
                        new ListTile(
                          title: Text("Add your Location"),
                          trailing: new Icon(
                            Icons.pin_drop,
                            // size: 30.0,
                          ),
                          onTap: () => {
                            Navigator.of(context).pop(),
                            Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new AddMarker(aadhar, role),
                              ),
                            ),
                          },
                        ),
                        new Divider(),
                      ],
                    )
                  : new Divider(),
              new ListTile(
                title: Text("Logout"),
                trailing: new Icon(Icons.exit_to_app),
              ),
              Divider(),
              new ListTile(
                title: Text("Close"),
                trailing: Icon(Icons.close),
                onTap: () => {Navigator.of(context).pop()},
              )
            ],
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            return Future.value(
                false); //return a `Future` with false value so this route cant be popped or closed.
          },
          child: new TabBarView(
            controller: _tabController,
            children: <Widget>[
              //new CameraScreen(),
              Market(),
              (role == "Farmer") ? new SchemeHome() : Page(),
              // new StatusScreen(),
              new CallsScreen(),
            ],
          ),
          // floatingActionButton: new FloatingActionButton(
          //   backgroundColor: Theme.of(context).accentColor,
          //   child: new Icon(
          //     Icons.message,
          //     color: Colors.white,
          //   ),
          //   onPressed: () => print("open chats"),
          // ),
        ));
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Requests"),
    );
  }
}
