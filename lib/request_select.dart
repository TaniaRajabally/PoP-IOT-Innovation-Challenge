import 'package:flutter/material.dart';
import 'package:pop/maps.dart';

class ListMap extends StatefulWidget {
  String uid;
  ListMap(this.uid);
  @override
  _ListMapState createState() => _ListMapState(uid);
}

class _ListMapState extends State<ListMap> {
  String uid;
  _ListMapState(this.uid);
  @override
  Widget build(BuildContext context) {
    return
        // MaterialApp(
        // debugShowCheckedModeBanner: false,
        // title: 'ListViews',
        // theme: ThemeData(
        //   primarySwatch: Colors.teal,
        // ),
        // home:
        Scaffold(
      appBar: AppBar(title: Text('Locate StakeHolders')),
      body: BodyLayout(uid),
    );
    //);
  }
}

class BodyLayout extends StatelessWidget {
  String uid;
  BodyLayout(this.uid);
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }

  // replace this function with the code in the examples
  Widget _myListView(BuildContext context) {
    return ListView(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new MapHome('Shop', uid)));
          },
          child: ListTile(
            title: Text('Shops'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new MapHome('Warehouse', uid)));
          },
          child: ListTile(
            title: Text('Warehouses '),
          ),
        ),
        GestureDetector(
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new MapHome('Bank', uid)));
            },
            title: Text('Banks '),
          ),
        ),
        GestureDetector(
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new MapHome('ColdStorage', uid)));
            },
            title: Text('ColdStorage'),
          ),
        ),
        GestureDetector(
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new MapHome('All', uid)));
            },
            title: Text('All'),
          ),
        ),
      ],
    );
  }
}
