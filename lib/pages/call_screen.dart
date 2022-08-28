import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:firebase_database/firebase_database.dart';
import 'package:pop/widgets/newstile.dart';

class CallsScreen extends StatefulWidget {
  @override
  _CallsScreenState createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  List<Widget> allData = [];
  int status = 0;
  @override
  void initState() {
    super.initState();
    final db = FirebaseDatabase.instance.reference();
    db.child("News").once().then((DataSnapshot snap) {
      //var keys = snap.value.
      var data = snap.value;
      allData.clear();
      //print(keys);
      for (var i in data) {
        if (i != null) {
          print(i['date']);
          print(i['data']);
          print("----");
          print(allData);

          setState(() {
            // print("data length");
            // print(allData.length);
            allData.add(NewsItem(i['data'], i['date']));
          });
        }
      }
      setState(() {
        status = 1;
      });

      //print(data);
    });

    print(allData);
  }

  @override
  Widget build(BuildContext context) {
    // return new Center(
    //   child: new Text(
    //     "News Alerts",
    //     style: new TextStyle(fontSize: 20.0),
    //   ),
    return (status == 0)
        ? Scaffold(
            body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Color(0xff045791)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  prefix0.Expanded(
                      flex: 2,
                      child: Container(
                        child: prefix0.Column(
                          mainAxisAlignment: prefix0.MainAxisAlignment.center,
                          children: <Widget>[
                            prefix0.CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  AssetImage('assets/img/login_logo.png'),
                              radius: 50,
                              // child: Icon(
                              //   Icons.shopping_cart,
                              //   color: Colors.greenAccent,
                              //   size: 50.0,
                              // )
                            ),
                            Padding(
                              padding: prefix0.EdgeInsets.only(top: 10.0),
                            ),
                            Text(
                              "AgriConnect",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: prefix0.FontWeight.bold),
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: prefix0.MainAxisAlignment.center,
                        children: <Widget>[
                          prefix0.CircularProgressIndicator(),
                          Padding(
                            padding: prefix0.EdgeInsets.only(top: 20.0),
                          ),
                          Text("Simplying Agricultural needs for Everyone",
                              style: prefix0.TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0,
                                  fontWeight: prefix0.FontWeight.bold))
                        ],
                      ))
                ],
              )
            ],
          ))
        : ListView.builder(
            itemCount: allData.length,
            itemBuilder: (context, i) => new Column(children: allData));
  }

  // void writeData() {
  //   int id = 2;
  //   db.child("News").child('$id').set({'data': '2'});
  // }

}
// class CallsScreen extends StatelessWidget {
//   final db = FirebaseDatabase.instance.reference();
//   @override
//   Widget build(BuildContext context) {
//     // return new Center(
//     //   child: new Text(
//     //     "News Alerts",
//     //     style: new TextStyle(fontSize: 20.0),
//     //   ),
//     return Row(
//       children: <Widget>[
//         RaisedButton(
//           child: Text("yo"),
//           onPressed: () {
//             writeData();
//           },
//         ),
//         RaisedButton(
//           child: Text("read"),
//           onPressed: () {
//             readData();
//           },
//         ),
//       ],
//     );
//   }

//   void writeData() {
//     int id = 2;
//     db.child("News").child('$id').set({'data': '2'});
//   }

//   void readData() {
//     db.child("News").once().then((DataSnapshot datasnapshot) {
//       var keys = datasnapshot.value.keys;
//       var data = datasnapshot.value;
//       print(datasnapshot.value);
//       for (var key in keys) {
//         print(data[key]['data']);
//       }
//       //print(datasnapshot);
// //       Map<dynamic, dynamic> fridgesDs = datasnapshot.value['id'];
// // //    print(fridgesDs.runtimeType);
// //       fridgesDs.forEach((key, value) {
// //         if (value) {
// //           print(key);
// //         }
// //       });
//     });
//   }
// }
