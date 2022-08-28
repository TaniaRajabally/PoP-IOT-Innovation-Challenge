// import 'package:flutter/material.dart';

// class StatusScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Center(
//       child: new Text(
//         "Locate",
//         style: new TextStyle(fontSize: 20.0),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// void main() => runApp(MyApp());

class StatusScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<StatusScreen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;

  static const LatLng _center = const LatLng(45.521563, -122.677433);
  Set<Marker> markers = Set();
  MapType _currentMapType = MapType.normal;
  LatLng centerPosition;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
      print("dddd" + _currentMapType.toString());
    });
  }

  void _onAddMarkerButtonPressed() {
    InfoWindow infoWindow =
        InfoWindow(title: "Location" + markers.length.toString());
    Marker marker = Marker(
      markerId: MarkerId(markers.length.toString()),
      infoWindow: infoWindow,
      position: centerPosition,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    setState(() {
      markers.add(marker);
    });
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: new ThemeData(
    //     primaryColor: const Color(0xFF02BB9F),
    //     primaryColorDark: const Color(0xFF167F67),
    //     accentColor: const Color(0xFF02BB9F),
    // ),
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Locate StakeHolders',
          // style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            mapType: _currentMapType,
            myLocationEnabled: true,
            markers: markers,
            onCameraMove: _onCameraMove,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          // Container(
          //     //alignment: Alignment(-1.0, -1.0),
          //     //constraints: BoxConstraints(maxHeight: ),
          //     //             decoration: new BoxDecoration(
          //     //   borderRadius: new BorderRadius.circular(16.0),
          //     //   color: Colors.green,
          //     // ),
          //     child: Row(
          //   children: <Widget>[
          //     Align(
          //       alignment: Alignment.topRight,
          //       child: IconButton(
          //           icon: Icon(FontAwesomeIcons.searchMinus,
          //               color: Color(0xff6200ee)),
          //           onPressed: () {
          //             zoomVal--;
          //             _minus(zoomVal);
          //           }),
          //     ),
          //     Align(
          //       alignment: Alignment.topLeft,
          //       child: IconButton(
          //           icon: Icon(FontAwesomeIcons.searchPlus,
          //               color: Color(0xff6200ee)),
          //           onPressed: () {
          //             zoomVal++;
          //             _plus(zoomVal);
          //           }),
          //     ),
          //   ],
          // )
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: new FloatingActionButton(
                heroTag: "bt1",
                onPressed: _onMapTypeButtonPressed,
                child: new Icon(
                  Icons.map,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: new FloatingActionButton(
                heroTag: "bt2",
                onPressed: _onAddMarkerButtonPressed,
                child: new Icon(
                  Icons.edit_location,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    //);
  }

  void _onCameraMove(CameraPosition position) {
    centerPosition = position.target;
  }
}

// Widget _zoomminusfunction() {

//     return Align(
//       alignment: Alignment.topLeft,
//       child: IconButton(
//             icon: Icon(FontAwesomeIcons.searchMinus,color:Color(0xff6200ee)),
//             onPressed: () {
//               zoomVal--;
//              _minus( zoomVal);
//             }),
//     );
//  }
//  Widget _zoomplusfunction() {

//     return Align(
//       alignment: Alignment.topLeft,
//       child: IconButton(
//             icon: Icon(FontAwesomeIcons.searchPlus,color:Color(0xff6200ee)),
//             onPressed: () {
//               zoomVal++;
//               _plus(zoomVal);
//             }),
//     );
//  }
