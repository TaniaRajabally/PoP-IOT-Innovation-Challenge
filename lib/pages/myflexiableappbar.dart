import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyFlexiableAppBar extends StatelessWidget {

  final double appBarHeight = 66.0;

  const MyFlexiableAppBar();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + appBarHeight,
      child: new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Container(child: new Text(
                    //   "Market Crop Analysis",
                    //     style: const TextStyle(
                    //         color: Colors.white,
                    //         //fontFamily: 'Poppins',
                    //         fontSize: 28.0
                    //     )
                    // ),),
                    Container(child: new Text(
                        "Agro-Market",
                        style: const TextStyle(
                            color: Colors.white,
                            //fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: 36.0
                        )
                    ),),
                  ],),),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: new Text(
                          "  Market Crop Analysis",
                          style: const TextStyle(
                              color: Colors.white70,
                              //fontFamily: 'Poppins',
                              fontSize: 20.0
                          )
                      ),
                    ),),

                    Container(child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Icon(
                        FontAwesomeIcons.longArrowAltUp, color: Colors.green,),
                    ),),

                  ],),
              ),


              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0,left:8.0),
                      child: new Text(
                          "Prices",
                          style: const TextStyle(
                              color: Colors.white70,
                             // fontFamily: 'Poppins',
                              fontSize: 16.0
                          )
                      ),
                    ),),

                    Container(child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0,right:8.0),
                      child: Container(
                          child: Row(children: <Widget>[
                            Container(child: Icon(
                              FontAwesomeIcons.calendarAlt, color: Colors.white,
                            ),),
                            SizedBox(width: 10,),
                            Container(child: Text(
                              'Latest', style: const TextStyle(
                                color: Colors.white70,
                                //fontFamily: 'Poppins',
                                fontSize: 16.0
                            ),),),
                          ],)

                      ),
                    ),),


                  ],),
              ),
            ],)
      ),
      decoration: new BoxDecoration(
        color: Color(0xff045791),
      ),
    );
  }
}