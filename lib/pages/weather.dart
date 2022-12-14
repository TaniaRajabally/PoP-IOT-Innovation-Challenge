// import 'package:flutter/material.dart';
// //import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as LocationManager;

// double lat;
// double lon;

// Future<void> getUserLocation() async {
//   var currentLocation = <String, double>{};
//   final location = LocationManager.Location();
//   try {
//     currentLocation = await location.getLocation();
//     lat = currentLocation["latitude"];
//     lon = currentLocation["longitude"];
//     //final center = LatLng(lat, lng);
//     return null;
//   } on Exception {
//     currentLocation = null;
//     return null;
//   }
// }

// class WeatherApp extends StatefulWidget {
//   @override
//   _WeatherAppState createState() => _WeatherAppState();
// }

// class _WeatherAppState extends State<WeatherApp> {
// String error;

//   @override
//   void initState() async {
//     // TODO: implement initState
//     super.initState();
// try {
//       await getUserLocation();

//       error = null;
//     } on PlatformException catch (e) {
//       if (e.code == 'PERMISSION_DENIED') {
//         error = 'Permission denied';
//       } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
//         error =
//             'Permission denied - please ask the user to enable it from the app settings';
//       }

//       location = null;
//     }

//     try{await getUserLocation();}
//     catch

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text("$lat"),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:flutter/services.dart';

import 'package:pop/widgets/Weather.dart';
import 'package:pop/widgets/WeatherItem.dart';
import 'package:pop/models/WeatherData.dart';
import 'package:pop/models/ForecastData.dart';

// void main() => runApp(new MyApp());

class WeatherApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<WeatherApp> {
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;
  Location _location = new Location();
  String error;

  @override
  void initState() {
    super.initState();

    loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff045791),
        appBar: AppBar(
          title: Text('Weather ForeCast'),
        ),
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: weatherData != null
                      ? Weather(weather: weatherData)
                      : Container(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isLoading
                      ? CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: new AlwaysStoppedAnimation(Colors.white),
                        )
                      : IconButton(
                          icon: new Icon(Icons.refresh),
                          tooltip: 'Refresh',
                          onPressed: loadWeather,
                          color: Colors.white,
                        ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200.0,
                child: forecastData != null
                    ? ListView.builder(
                        itemCount: forecastData.list.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => WeatherItem(
                            weather: forecastData.list.elementAt(index)))
                    : Container(),
              ),
            ),
          )
        ])));
    // return MaterialApp(
    //   title: 'Flutter Weather App',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: Scaffold(
    //       backgroundColor: Colors.blueGrey,
    //       appBar: AppBar(
    //         title: Text('Flutter Weather App'),
    //       ),
    //       body: Center(
    //           child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
    //         Expanded(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: weatherData != null
    //                     ? Weather(weather: weatherData)
    //                     : Container(),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: isLoading
    //                     ? CircularProgressIndicator(
    //                         strokeWidth: 2.0,
    //                         valueColor:
    //                             new AlwaysStoppedAnimation(Colors.white),
    //                       )
    //                     : IconButton(
    //                         icon: new Icon(Icons.refresh),
    //                         tooltip: 'Refresh',
    //                         onPressed: loadWeather,
    //                         color: Colors.white,
    //                       ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         SafeArea(
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Container(
    //               height: 200.0,
    //               child: forecastData != null
    //                   ? ListView.builder(
    //                       itemCount: forecastData.list.length,
    //                       scrollDirection: Axis.horizontal,
    //                       itemBuilder: (context, index) => WeatherItem(
    //                           weather: forecastData.list.elementAt(index)))
    //                   : Container(),
    //             ),
    //           ),
    //         )
    //       ]))),
    // );
  }

  loadWeather() async {
    setState(() {
      isLoading = true;
    });

    Map<String, double> location;

    try {
      location = await _location.getLocation();

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    if (location != null) {
      final lat = location['latitude'];
      final lon = location['longitude'];

      final weatherResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/weather?APPID=0721392c0ba0af8c410aa9394defa29e&lat=${lat.toString()}&lon=${lon.toString()}');
      final forecastResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/forecast?APPID=0721392c0ba0af8c410aa9394defa29e&lat=${lat.toString()}&lon=${lon.toString()}');

      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        return setState(() {
          weatherData =
              new WeatherData.fromJson(jsonDecode(weatherResponse.body));
          forecastData =
              new ForecastData.fromJson(jsonDecode(forecastResponse.body));
          isLoading = false;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }
}
