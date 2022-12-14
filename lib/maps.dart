import 'dart:async';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:pop/markerlist.dart';
import 'package:pop/pages/profile.dart' as prefix0;
import 'place_detail.dart';
import 'package:firebase_database/firebase_database.dart';
import './models/marker_model.dart';

const kGoogleApiKey = "AIzaSyCbdgLq_pjF9jgNxFS4umaVen9UFBLJoI4";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

// void main() {
//   runApp(MaterialApp(
//     title: "Your Location",
//     home: Home(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

class MapHome extends StatefulWidget {
  final String a;
  String uid;
  MapHome(this.a, this.uid);
  @override
  State<StatefulWidget> createState() {
    return HomeState(a, uid);
  }
}

class HomeState extends State<MapHome> {
  final String map;
  String uid;
  HomeState(this.map, this.uid);
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<PlacesSearchResult> places = [];
  bool isLoading = false;
  String errorMessage;
  final databaseReference = FirebaseDatabase.instance.reference();

  List<Widget> allMarkers = [];
  // Widget m;
  void initState() {
    super.initState();
    final databaseReference = FirebaseDatabase.instance.reference();
    String desc;
    databaseReference.child('markers').once().then((DataSnapshot snapshot) {
      var aaa = snapshot.value;
      print(aaa);
      allMarkers.clear();
      aaa.forEach((k, v) {
        print(v['lat']);
        var lat1 = v['lat'];
        var lng1 = v['lng'];
        var lat_final = double.parse('$lat1');
        assert(lat_final is double);
        var lng_final = double.parse('$lng1');
        assert(lng_final is double);
        String description = v['descripion'];
        if (v['desc'] == 0) {
          description = 'Bank';
        }
        if (v['desc'] == 1) {
          description = 'Warehouse';
        }
        if (v['desc'] == 2) {
          description = 'ColdStorage';
        }
        if (v['desc'] == 3) {
          description = 'Shop';
        }
        setState(() {
          if (map == 'All') {
            allMarkers.add(GestureDetector(
              onTap: () {
                mapController.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(lat_final, lng_final),
                  zoom: 15,
                  tilt: 50.0,
                  bearing: 45.0,
                )));
              },
              child: MarkerModel(v['descripion'], lat_final, lng_final),
            ));
          } else if (map == description) {
            allMarkers.add(GestureDetector(
              onTap: () {
                mapController.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(lat_final, lng_final),
                  zoom: 15,
                  tilt: 50.0,
                  bearing: 45.0,
                )));
              },
              child: MarkerModel(v['descripion'], lat_final, lng_final),
            ));
          }

          //  m = MarkerModel(v['descripion'],lat_final, lng_final);
          // count++;
          //print(count);
        });
      });

      print(allMarkers[0].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget expandedChild;
    if (isLoading) {
      expandedChild = Center(child: CircularProgressIndicator(value: null));
    } else if (errorMessage != null) {
      expandedChild = Center(
        child: Text(errorMessage),
      );
    }
    //else {
    //   expandedChild = buildPlacesList();
    // }

    return Scaffold(
        key: homeScaffoldKey,
        appBar: AppBar(
          title: const Text("Maps"),
          actions: <Widget>[
            isLoading
                ? IconButton(
                    icon: Icon(Icons.timer),
                    onPressed: () {},
                  )
                : IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      refresh();
                    },
                  ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _handlePressButton();
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: new Expanded(
                  child: SizedBox(
                height: 500,
                child: new GoogleMap(
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                    initialCameraPosition:
                        const CameraPosition(target: LatLng(0.0, 0.0)),
                    markers: Set<Marker>.of(markers.values)),
              )),
            ),
            // Expanded(child:
            // SizedBox(
            //   height: 22,
            //   child: Container(
            //     height: 20,
            //     child : markerList())) ,
            // )
            _buildMapCards(),
          ],
        ));
  }

  Widget _buildMapCards() {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 100.0,
            child: buildCards()));
  }

  void refresh() async {
    final center = await getUserLocation();

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center == null ? LatLng(0, 0) : center, zoom: 1.0)));
    getNearbyPlaces(center);
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    refresh();
  }

  Future<LatLng> getUserLocation() async {
    var currentLocation = <String, double>{};
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation();
      final lat = currentLocation["latitude"];
      final lng = currentLocation["longitude"];
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  void getNearbyPlaces(LatLng center) async {
    setState(() {
      this.isLoading = true;
      this.errorMessage = null;
    });

    final location = Location(center.latitude, center.longitude);
    print('oyeeeeeeeeeeeeeee');
    num d = location.lat;

    print(d);
    final result = await _places.searchNearbyWithRadius(location, 2500);
    setState(() {
      this.isLoading = false;
      if (result.status == "OK") {
        this.places = result.results;
        result.results.forEach((f) {
          final markerOptions = Marker(
              position:
                  LatLng(f.geometry.location.lat, f.geometry.location.lng),
              infoWindow:
                  InfoWindow(title: "${f.name}", snippet: "${f.types?.first}"));

          // mapController.addMarker(markerOptions);
        });
        String desc;
        databaseReference
            .child('markers')
            .child('')
            .once()
            .then((DataSnapshot snapshot) {
          print(snapshot.value);
          var aaa = snapshot.value;
          aaa.forEach((k, v) {
            //print('${v['lat']}');
            var lat1 = v['lat'];
            var lng1 = v['lng'];
            var lat_final = double.parse('$lat1');
            assert(lat_final is double);
            var lng_final = double.parse('$lng1');
            assert(lng_final is double);
            if (v['desc'] == 0) {
              desc = 'Bank';
            }
            if (v['desc'] == 1) {
              desc = 'Warehouse';
            }
            if (v['desc'] == 2) {
              desc = 'ColdStorage';
            }
            if (v['desc'] == 3) {
              desc = 'Shop';
            }

            if (map == 'All') {
              final markerOptions = Marker(
                markerId: MarkerId(k),
                position: LatLng(
                  lat_final,
                  lng_final,
                ),
                infoWindow: InfoWindow(title: desc, snippet: v['descripion']),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListMarker(v['uid'], lat_final, lng_final, uid)));
                },

                // position:
                //     LatLng(lat_final, lng_final),
                // infoWindowText: InfoWindowText(desc, 'kuch bhi'),
              );
              setState(() {
                markers[MarkerId(k)] = markerOptions;
              });
              //  mapController.addMarker(markerOptions);
              //  print('marker addesd');
              //  mapController.onMarkerTapped.add((markerOptions){
              //    Navigator.push(context, MaterialPageRoute(builder: (context) => ListMarker()));
              //  });
            } else if (map == desc) {
              final markerOptions = Marker(
                markerId: MarkerId(k),
                position: LatLng(
                  lat_final,
                  lng_final,
                ),
                infoWindow: InfoWindow(title: desc, snippet: v['descripion']),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListMarker(v['uid'], lat_final, lng_final, uid)));
                },
              );
              setState(() {
                markers[MarkerId(k)] = markerOptions;
              });

              //       final markerOptions = MarkerOptions(
              //     position:
              //         LatLng(lat_final, lng_final),
              //     infoWindowText: InfoWindowText(desc, 'kuch bhi'),
              //   );

              //  mapController.addMarker(markerOptions);
              //  print('marker addesd');
              //  mapController.onMarkerTapped.add((markerOptions){
              //    Navigator.push(context, MaterialPageRoute(builder: (context) => ListMarker()));
              //  });
            }
          });
          //     for(dynamic abc in  snapshot.value){
          //       print(abc);
          //     }
          //       if (abc != null){
          //         print('absssssss');
          //       print(abc['lat']);
          //       print(abc['lng']);
          //       var lat1 = abc['lat'];
          //       var lng1 = abc['lng'];
          //     var lat_final = double.parse('$lat1');
          // assert(lat_final is double);
          // var lng_final = double.parse('$lng1');
          // assert(lng_final is double);
          //       final markerOptions = MarkerOptions(
          //         position:
          //             LatLng(lat_final, lng_final),
          //       );
          //       mapController.addMarker(markerOptions);
          //     }

          //    }

          // });
        });
      } else {
        this.errorMessage = result.errorMessage;
      }
    });
    // mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //   target: LatLng(19.2125758, 72.8232875),
    //   zoom: 15,
    //   tilt: 50.0,
    //   bearing: 45.0,
    // )));
  }

  void sendRequest() {
    print('Request sent');
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _handlePressButton() async {
    try {
      final center = await getUserLocation();
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          strictbounds: center == null ? false : true,
          apiKey: kGoogleApiKey,
          onError: onError,
          mode: Mode.fullscreen,
          language: "en",
          location: center == null
              ? null
              : Location(center.latitude, center.longitude),
          radius: center == null ? null : 10000);

      showDetailPlace(p.placeId);
    } catch (e) {
      return;
    }
  }

  Future<Null> showDetailPlace(String placeId) async {
    if (placeId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlaceDetailWidget(placeId)),
      );
    }
  }

  Widget buildCards() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: allMarkers.length,
        itemBuilder: (context, i) {
          return Container(child: allMarkers[i]);
          //     GestureDetector(

          //       onTap: () {
          //                   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          //   target: LatLng(19.2125758,75.8232875),
          //   zoom: 15,
          //   tilt: 50.0,
          //   bearing: 45.0,
          // )));
          //       },
          //       child: Container(
          //         child: allMarkers[i] ,
          //       ) ,
          //     );
        });
  }

  Future<void> _gotoLocation(double lat, double long) async {
    print('this is mao controller');
    print(mapController);
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

  ListView buildPlacesList() {
    final placesWidget = places.map((f) {
      List<Widget> list = [
        Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Text(
            f.name,
            style: Theme.of(context).textTheme.subtitle,
          ),
        )
      ];
      if (f.formattedAddress != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.formattedAddress,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ));
      }

      if (f.vicinity != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.vicinity,
            style: Theme.of(context).textTheme.body1,
          ),
        ));
      }

      if (f.types?.first != null) {
        list.add(Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Text(
            f.types.first,
            style: Theme.of(context).textTheme.caption,
          ),
        ));
      }

      return Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
        child: Card(
          child: InkWell(
            onTap: () {
              showDetailPlace(f.placeId);
            },
            highlightColor: Colors.lightBlueAccent,
            splashColor: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: list,
              ),
            ),
          ),
        ),
      );
    }).toList();

    return ListView(shrinkWrap: true, children: placesWidget);
  }
}

// class markerList extends StatefulWidget {
//   @override
//   _markerListState createState() => _markerListState();
// }
// int count  = 0;
// class _markerListState extends State<markerList> {
//     List<Widget> allMarkers = [];
//     void initState(){
//       super.initState();
//       final databaseReference = FirebaseDatabase.instance.reference();
//       String desc;
//       databaseReference.child('markers').once().then((DataSnapshot snapshot) {
//           var aaa = snapshot.value;
//           print(aaa);
//           allMarkers.clear();
//            aaa.forEach((k, v)
//           {
//             print(v['lat']);
//             var lat1 = v['lat'];
//           var lng1 = v['lng'];
//                 var lat_final = double.parse('$lat1');
//       assert(lat_final is double);
//       var lng_final = double.parse('$lng1');
//       assert(lng_final is double);
//             setState(() {
//            allMarkers.add(MarkerModel(v['descripion'],lat_final, lng_final ));

//           // count++;
//           //print(count);
//           });
//           });
//           print(allMarkers[0].toString());

//       });
//     }
//   @override
//   Widget buildCards(BuildContext context) {
//      return ListView.builder(
//        shrinkWrap: true,
//        scrollDirection: Axis.horizontal,
//         itemCount: allMarkers.length,
//          itemBuilder: (context,i) { return
//         //  Container(child: allMarkers[i]

//         //  );
//         GestureDetector(

//           onTap: () => _gotoLocation(19.2125758, 72.8232875),
//           child: allMarkers[i],
//         );
//          }
//         );
//   }

//   Future<void> _gotoLocation(double lat, double long) async {
//     print('this is mao controller');
//     print(mapController);
//     mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//       target: LatLng(lat, long),
//       zoom: 15,
//       tilt: 50.0,
//       bearing: 45.0,
//     )));
//   }

// }

class ListMarker extends StatelessWidget {
  String Wuid;
  double lat, lng;
  String Uuid;

  ListMarker(this.Wuid, this.lat, this.lng, this.Uuid);
  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Connect with StakeHolder")),
        body: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30.0),
                Text(
                  " Send Request ?",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  child: Text('Yes'),
                  //clipBehavior: ,
                  onPressed: () {
                    databaseReference
                        .child('Requests')
                        .child('$Wuid')
                        .push()
                        .set(
                      {
                        'Farmer': Uuid,
                        'lat': lat,
                        'lng': lng,
                      },
                    );
                    Navigator.of(context).pop();
                    //  print('yes');
                  },
                )
              ],
            )
          ],
        ));
  }
}
