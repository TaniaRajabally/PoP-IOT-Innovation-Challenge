import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<MarkerModel> list = new List<MarkerModel>();

class MarkerModel extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();
  String name;
  double lat, lng;
  MarkerModel(
    this.name,
    this.lat,
    this.lng,
  );

  @override
  // Widget build(BuildContext context) {
  //   return Container(

  //   );
  // }
  Widget build(BuildContext context) {
    return Container(
      // onTap: () {
      //   _gotoLocation(lat, lng);
      // },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0xff045791),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   width: 180,
                  //   height: 200,
                  //   child: ClipRRect(
                  //     borderRadius: new BorderRadius.circular(24.0),
                  //     child: Image(
                  //       fit: BoxFit.fill,
                  //       image: NetworkImage(_image),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(name),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            restaurantName,
            style: TextStyle(
                color: Color(0xff045791),
                fontSize: 10.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Divider(),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              "Contact",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 10.0,
              ),
            )),
            SizedBox(
              width: 15.0,
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.phone,
                color: Colors.amber,
                size: 10.0,
              ),
            ),
            //     Container(
            //       child: Icon(
            //         FontAwesomeIcons.solidStar,
            //         color: Colors.amber,
            //         size: 15.0,
            //       ),
            //     ),
            //     Container(
            //       child: Icon(
            //         FontAwesomeIcons.solidStar,
            //         color: Colors.amber,
            //         size: 15.0,
            //       ),
            //     ),
            //     Container(
            //       child: Icon(
            //         FontAwesomeIcons.solidStar,
            //         color: Colors.amber,
            //         size: 15.0,
            //       ),
            //     ),
            //     Container(
            //       child: Icon(
            //         FontAwesomeIcons.solidStarHalf,
            //         color: Colors.amber,
            //         size: 15.0,
            //       ),
            //     ),
            //     Container(
            //         child: Text(
            //       "(946)",
            //       style: TextStyle(
            //         color: Colors.black54,
            //         fontSize: 18.0,
            //       ),
            //     )),
          ],
        )),
        SizedBox(height: 5.0),
        // Container(
        //     child: Text(
        //   "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
        //   style: TextStyle(
        //     color: Colors.black54,
        //     fontSize: 18.0,
        //   ),
        // )),
        // SizedBox(height: 5.0),
        // Container(
        //     child: Text(
        //   "8655138960",
        //   style: TextStyle(
        //       color: Colors.black54,
        //       fontSize: 8.0,
        //       fontWeight: FontWeight.bold),
        // )),
      ],
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

// static List<MarkerModel> getList ()
// {
//    final databaseReference = FirebaseDatabase.instance.reference();
//   print('lisissisisisisisis');
//     String desc;
//         databaseReference.child('markers').once().then((DataSnapshot snapshot) {
//            print('descriptiosdaaaaaaaaaaaaaaaaaaaan');
//          print(snapshot.value);
//          var aaa = snapshot.value;
//          aaa.forEach((k, v) {
//           //print('${v['lat']}');
//           var lat1 = v['lat'];
//           var lng1 = v['lng'];
//                 var lat_final = double.parse('$lat1');
//       assert(lat_final is double);
//       var lng_final = double.parse('$lng1');
//       assert(lng_final is double);
//           if (v['desc'] == 0){ desc= 'Farmer';}
//           if (v['desc'] == 1){ desc= 'Warehouse';}
//           if (v['desc'] == 2){ desc= 'Shop';}
//           // var description = v['description'];

//           // print(description);

//          MarkerModel m = new MarkerModel(v['descripion'],lat_final, lng_final);
//          print('Marker object');
//          print(m.name);
//          list.add(m);
//          print(list);

//          });

//         });
//         print('function list');
//         print(list);
//         return list;

// }
