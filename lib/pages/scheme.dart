import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pop/models/soilscheme.dart';
import 'voice.dart';

class Scheme extends StatefulWidget {
  final schemetype;
  Scheme(this.schemetype);
  @override
  _SchemeState createState() => _SchemeState();
}

class _SchemeState extends State<Scheme> {
  List<SoilScheme> schemeData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var yo = widget.schemetype;
    print(yo);

    final schemedb = FirebaseDatabase.instance.reference();
    schemedb
        .child("Schemes")
        .child('Maharashtra')
        .child('$yo')
        .once()
        .then((DataSnapshot snap) {
      //var keys = snap.value.
      var data = snap.value;
      schemeData.clear();
      print(data);
      //schemeData.clear();
      for (var i in data) {
        if (i != null) {
          print(i);
          print(i['type']);
          print("----");
          var s = SoilScheme(i['assistance'], i['type'], i['scheme']);
          // schemeData.add(s);
          // for (var j in i) {
          //   print(j);
          // }

          setState(() {
            //   //       // print("data length");
            //   //       // print(allData.length);
            schemeData.add(s);
            print(schemeData);
          });
        }
      }

      //print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Personalized Schemes"),
        ),
        body: ListView.builder(
            itemCount: schemeData.length,
            itemBuilder: (context, i) => Card(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 260.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://ak0.picdn.net/shutterstock/videos/14842060/thumb/1.jpg"),
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new Voice(schemeData[i].type),
                            ),
                          );
                        },
                        child: ExpansionTile(
                          // trailing: Icon(Icons.star),
                          title: Text(
                            schemeData[i].type,
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.bold),
                          ),

                          children: <Widget>[
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: <Widget>[
                            //     SizedBox(
                            //       width: 15.0,
                            //     ),
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: <Widget>[
                            //         Text(
                            //           'Assistance Provided',
                            //           style: TextStyle(
                            //             color: Colors.black,
                            //             fontSize: 15,
                            //           ),
                            //         ),
                            //         SizedBox(
                            //           height: 3,
                            //         ),
                            //         Text(
                            //           'AAA',
                            //           style: TextStyle(
                            //             color: Colors.grey,
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //     Column(
                            //       children: <Widget>[
                            //         SizedBox(
                            //           height: 8,
                            //         ),
                            //         Row(
                            //           children: <Widget>[
                            //             IconButton(
                            //                 // icon: Icon(
                            //                 //   Icons.person,
                            //                 //   size: 30,
                            //                 // ),
                            //                 icon: Icon(
                            //                   Icons.people,
                            //                   color: Colors.black,
                            //                 ),
                            //                 onPressed: () {}),
                            //             // IconButton(
                            //             //     icon: Icon(
                            //             //       Icons.headset,
                            //             //       size: 15,
                            //             //     ),
                            //             //     onPressed: () {}),
                            //           ],
                            //         )
                            //       ],
                            //     )
                            //   ],
                            // ),
                            //Container(child: ,)
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: <Widget>[
                            //     Text(
                            //       "Assistance Provided : ",
                            //       style: TextStyle(
                            //           fontSize: 15.0,
                            //           fontWeight: FontWeight.bold),
                            //     ),
                            //     SizedBox(height: 5.0),
                            //     Text(schemeData[i].assistance),
                            //     SizedBox(
                            //       width: 20.0,
                            //     ),
                            //     Icon(Icons.volume_up)
                            //   ],
                            // ),

                            SizedBox(height: 10.0),
                            Text(
                              "Assistanc : ",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.0),
                            Text(schemeData[i].scheme),

                            SizedBox(height: 10.0),
                            Text(
                              "Organization / Scheme : ",
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.0),
                            Text(schemeData[i].scheme)
                            //Voice(),
                          ],
                        ),
                      )
                    ],
                  ),
                )
            //new Column(
            //  children: <Widget>[
            //     new Divider(
            //       height: 10.0,
            //     ),
            //     new ListTile(
            //       onTap: () {
            //         print("pressed");
            //         Navigator.of(context).push(
            //           new MaterialPageRoute(
            //             builder: (BuildContext context) =>
            //                 new Voice(schemeData[i].type),
            //           ),
            //         );
            //       },
            //       leading: new CircleAvatar(
            //         foregroundColor: Theme.of(context).primaryColor,
            //         backgroundColor: Colors.grey,
            //         backgroundImage: new NetworkImage(
            //             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ87rSp4-aKd1_WlQ4Mp08tHXJMQMRDN9_7u0HZp9nZanl4hOq3"),
            //       ),
            //       title: new Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           new Text(schemeData[i].type,
            //               style: new TextStyle(
            //                   fontWeight: FontWeight.bold, fontSize: 10.0)),
            //           // new Text(
            //           //   schemeData[i].date,
            //           //   style: new TextStyle(color: Colors.grey, fontSize: 14.0),
            //           // ),
            //         ],
            //       ),
            //       subtitle: new Container(
            //           height: 30.0,
            //           padding: const EdgeInsets.only(top: 5.0),
            //           child: Column(children: [
            //             new Text(
            //               schemeData[i].assistance,
            //               style:
            //                   new TextStyle(color: Colors.black26, fontSize: 8.0),
            //             ),
            //             Text(
            //               schemeData[i].scheme,
            //               style: new TextStyle(color: Colors.grey, fontSize: 8.0),
            //             ),
            //           ])),
            //     )
            // ],
            //)
            ));
  }
}
