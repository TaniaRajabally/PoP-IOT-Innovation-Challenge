import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import './models/marker_model.dart';

class markerList extends StatefulWidget {
  @override
  _markerListState createState() => _markerListState();
}

int count = 0;

class _markerListState extends State<markerList> {
  List<Widget> allMarkers = [];
  void initState() {
    super.initState();
    print('Wubaaaaaaa');
    final databaseReference = FirebaseDatabase.instance.reference();
    String desc;
    databaseReference.child('markers').once().then((DataSnapshot snapshot) {
      var aaa = snapshot.value;
      //print(aaa);
      allMarkers.clear();
      aaa.forEach((k, v) {
        //print(v['lat']);
        var lat1 = v['lat'];
        var lng1 = v['lng'];
        var lat_final = double.parse('$lat1');
        assert(lat_final is double);
        var lng_final = double.parse('$lng1');
        assert(lng_final is double);
        setState(() {
          MarkerModel m = MarkerModel(v['descripion'], lat_final, lng_final);
          print('&&&&&&&&&&&&&&&&&&&&&&');
          print(m.lat);
          allMarkers.add(MarkerModel(v['descripion'], lat_final, lng_final));
          count++;
          print('count');
          //print(count);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: allMarkers.length,
        itemBuilder: (context, i) => new Container(child: allMarkers[i]));
  }
}
