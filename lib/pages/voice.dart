import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Voice extends StatefulWidget {
  final text;
  Voice(this.text);
  @override
  _VoiceState createState() => _VoiceState();
}

enum TtsState { playing, stopped }

class _VoiceState extends State<Voice> {
  String scheme;
  FlutterTts flutterTts;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scheme = widget.text;
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _speak() async {
    var result = await flutterTts.speak("$scheme");
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }
// List<dynamic> languages = await flutterTts.getLanguages;
// await flutterTts.setLanguage("en-US");

// await flutterTts.setSpeechRate(1.0);

// await flutterTts.setVolume(1.0);

// await flutterTts.setPitch(1.0);

// await flutterTts.isLanguageAvailable("en-US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Voice")),
        // body: Container(
        //     height: 50.0,
        //     child: Column(
        //       children: <Widget>[
        //         Expanded(
        //           flex: 2,
        //           child: Text(scheme, style: TextStyle(fontSize: 15.0)),
        //         ),
        //         Expanded(
        //             flex: 1,
        //             child: Container(
        //                 padding: EdgeInsets.only(top: 50.0),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                   children: [
        //                     _buildButtonColumn(Colors.green, Colors.greenAccent,
        //                         Icons.play_arrow, 'PLAY', _speak),
        //                     _buildButtonColumn(Colors.red, Colors.redAccent,
        //                         Icons.stop, 'STOP', _stop)
        //                   ],
        //                 )))
        //       ],
        //     )),

        body: Column(
          children: <Widget>[
            Text(scheme),
            Container(
                padding: EdgeInsets.only(top: 50.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButtonColumn(Colors.green, Colors.greenAccent,
                          Icons.play_arrow, 'PLAY', _speak),
                      _buildButtonColumn(Colors.red, Colors.redAccent,
                          Icons.stop, 'STOP', _stop)
                    ]))
          ],
        ));

    // return Container(
    //     height: 50.0,
    //     child: Column(
    //       children: <Widget>[
    //         Expanded(
    //           flex: 2,
    //           child: Text(scheme, style: TextStyle(fontSize: 15.0)),
    //         ),
    //         Expanded(
    //             flex: 1,
    //             child: Container(
    //                 padding: EdgeInsets.only(top: 50.0),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     _buildButtonColumn(Colors.green, Colors.greenAccent,
    //                         Icons.play_arrow, 'PLAY', _speak),
    //                     _buildButtonColumn(Colors.red, Colors.redAccent,
    //                         Icons.stop, 'STOP', _stop)
    //                   ],
    //                 )))
    //       ],
    //     ));
  }

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: color)))
        ]);
  }
}
