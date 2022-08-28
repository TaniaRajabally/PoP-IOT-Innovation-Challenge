import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/chat_model.dart';

class ChatScreen extends StatefulWidget {
  final schemetype;
  ChatScreen(this.schemetype);
  @override
  ChatScreenState createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  List allData;

  void initState() {
    super.initState();
    var scheme = widget.schemetype;
    print(scheme);
    // final db = FirebaseDatabase.instance.reference();
    // db
    //     .child("Schemes")
    //     .child("Maharashtra")
    //     .child('$scheme')
    //     .once()
    //     .then((DataSnapshot snap) {
    //   //var keys = snap.value.
    //   var data = snap.value;
    //   dummyData.clear();
    //   //print(keys);
    //   for (var i in data) {
    //     if (i != null) {
    //       print(i['date']);
    //       print(i['data']);
    //       print("----");
    //       print(allData);

    //       // setState(() {
    //       //   // print("data length");
    //       //   // print(allData.length);
    //       //   allData.add(NewsItem(i['data'], i['date']));
    //       // });
    //     }
    //   }

    //   //print(data);
    // });

    // print(allData);
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: dummyData.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new Divider(
            height: 10.0,
          ),
          new ListTile(
            leading: new CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: new NetworkImage(dummyData[i].avatarUrl),
            ),
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  dummyData[i].name,
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(
                  dummyData[i].date,
                  style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(
                dummyData[i].message,
                style: new TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
