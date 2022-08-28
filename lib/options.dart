import 'package:flutter/material.dart';
import 'package:pop/add_marker.dart';
import 'package:pop/home.dart';
import 'package:pop/maps.dart';
import 'package:pop/request_select.dart';
//import 'package:textts/maps.dart';
//import 'package:textts/maps_fancy.dart';

class Option extends StatelessWidget {
  final String num;

  Option(this.num);

  // Widget build(BuildContext context)
  // {
  //   return Scaffold(
  //       appBar: AppBar(
  //       title: Text('Options'),
  //   ) ,
  //   body: Center(

  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //       RaisedButton(onPressed: () {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  //       },
  //         child: Text('Audio Schemes'),
  //       ),
  //       RaisedButton(
  //         onPressed: () {},
  //         child: Text('Maps'),
  //         )
  //     ]
  //     ),
  //   )
  //   );

  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                //
                Tab(icon: Icon(Icons.surround_sound)),
                Tab(icon: Icon(Icons.pin_drop)),
                Tab(icon: Icon(Icons.map)),
                //Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Features'),
          ),
          body: TabBarView(
            children: [
              //
              Home(),
              AddMarker(num),
              ListMap(num),
            ],
          ),
        ),
      ),
    );
  }
}
