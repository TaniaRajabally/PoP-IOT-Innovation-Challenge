import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/foundation.dart';

final startColor = Color(0xFFaa7ce4);
final endColor = Color(0xFFe46792);
final titleColor = Color(0xff444444);
final textColor = Color(0xFFa9a9a9);
final shadowColor = Color(0xffe9e9f4);
final Color loginGradientStart = const Color(0xFF97D9E7);
final Color loginGradientEnd = const Color(0xFF17199C);

// void main() {
//   if (defaultTargetPlatform == TargetPlatform.iOS) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
//         .copyWith(statusBarBrightness: Brightness.dark));
//   }

//   runApp(MyApp());
// }

class Profile extends StatelessWidget {
  final aadhar, email, name, state, rewards, age, sex, role, crops;
  Profile(this.aadhar, this.email, this.name, this.state, this.rewards,
      this.age, this.sex, this.role, this.crops);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 180,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [loginGradientStart, loginGradientEnd])),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 50),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 40, left: 20),
                  //   child: IconButton(
                  //     icon: Icon(
                  //       Icons.arrow_back,
                  //       color: Colors.white,
                  //     ),
                  //     onPressed: () {},
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      '$role',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, right: 20),
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: ListView(
              children: <Widget>[
                new CardHolder(
                    aadhar, email, name, state, rewards, age, sex, role, crops),
                SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
        ],
      ),
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: Scaffold(
    //     body: Stack(
    //       children: <Widget>[
    //         Container(
    //           height: 180,
    //           decoration: BoxDecoration(
    //               gradient: LinearGradient(
    //                   colors: [loginGradientStart, loginGradientEnd])),
    //         ),
    //         Positioned(
    //           top: 0,
    //           right: 0,
    //           left: 0,
    //           child: Container(
    //             height: 80,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Padding(
    //                   padding: const EdgeInsets.only(top: 40, left: 20),
    //                   child: IconButton(
    //                     icon: Icon(
    //                       Icons.arrow_back,
    //                       color: Colors.white,
    //                     ),
    //                     onPressed: () {
    //                       print("yess");
    //                       Navigator.of(context).pop();
    //                     },
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.only(top: 40),
    //                   child: Text(
    //                     'Farmer',
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 20,
    //                     ),
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.only(top: 40, right: 20),
    //                   child: IconButton(
    //                     icon: Icon(
    //                       Icons.edit,
    //                       color: Colors.white,
    //                     ),
    //                     onPressed: () {},
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Container(
    //           child: ListView(
    //             children: <Widget>[
    //               new CardHolder(),
    //               SizedBox(
    //                 height: 200,
    //               )
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class CardHolder extends StatelessWidget {
  final aadhar, email, name, state, rewards, age, sex, role, crops;
  CardHolder(this.aadhar, this.email, this.name, this.state, this.rewards,
      this.age, this.sex, this.role, this.crops);

  // const CardHolder({
  //   Key key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 150, right: 20, left: 20),
      height: 600,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: titleColor.withOpacity(.1),
                blurRadius: 20,
                spreadRadius: 10),
          ]),
      child:
          new Card(aadhar, email, name, state, rewards, age, sex, role, crops),
    );
  }
}

class Card extends StatelessWidget {
  final aadhar, email, name, state, rewards, age, sex, role, crops;
  Card(this.aadhar, this.email, this.name, this.state, this.rewards, this.age,
      this.sex, this.role, this.crops);

  //   Key key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/ill.png'), fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                  color: Colors.blueAccent.withOpacity(.2), width: 1)),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '$name',
          style: TextStyle(
            color: titleColor,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '$state',
              style: TextStyle(color: textColor, fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 12,
              child: VerticalDivider(
                width: 2,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Age : $age',
              style: TextStyle(color: textColor, fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 12,
              child: VerticalDivider(
                width: 2,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '$sex',
              style: TextStyle(color: textColor, fontSize: 15),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.only(left: 20, right: 20, top: 8),
          width: 320,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 30,
                    spreadRadius: 5)
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Aadhar UID',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        '$aadhar',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                              // icon: Icon(
                              //   Icons.person,
                              //   size: 30,
                              // ),
                              icon: Icon(
                                Icons.people,
                                color: Colors.black,
                              ),
                              onPressed: () {}),
                          // IconButton(
                          //     icon: Icon(
                          //       Icons.headset,
                          //       size: 15,
                          //     ),
                          //     onPressed: () {}),
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Crops Grown',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),

              SizedBox(
                height: 10.0,
              ),
              Text('$crops', style: TextStyle(color: Colors.grey)),
              SizedBox(
                height: 10.0,
              ),
              // SizedBox(
              //   height: 10.0,
              // ),
              // Text(
              //   'Area Under Cultivation',
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 18,
              //   ),
              // ),
              // SizedBox(
              //   height: 10.0,
              // ),
              // Text('100 Acre', style: TextStyle(color: Colors.grey)),
              // SizedBox(
              //   height: 10.0,
              // ),
              Text(
                'Your Rewards',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text('$rewards coins', style: TextStyle(color: Colors.grey))
            ],
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 300,
              child: Divider(
                height: 1,
                color: titleColor.withOpacity(.3),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      // child: Icon(
                      //   Icons.group_work,
                      //   color: textColor,
                      //   size: 40,
                      // ),
                    ),
                  ),
                ),
                // Column(
                //   children: <Widget>[
                //     Text(
                //       'Dirbble',
                //       style: TextStyle(color: Colors.black, fontSize: 22),
                //     ),
                //     Text(
                //       '.com/raazcse',
                //       style: TextStyle(color: textColor, fontSize: 15),
                //     )
                //   ],
                // ),
                // Spacer(),
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        Icons.people,
                        color: textColor,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Referral Code',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    Text(
                      '$aadhar',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        Icons.content_copy,
                        color: textColor,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
