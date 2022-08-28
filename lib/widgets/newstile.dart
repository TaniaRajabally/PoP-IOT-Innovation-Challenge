import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  final String data, date;
  NewsItem(this.data, this.date);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        new Divider(
          height: 30.0,
        ),
        new ListTile(
          leading: new CircleAvatar(
            foregroundColor: Theme.of(context).primaryColor,
            backgroundColor: Colors.grey,
            backgroundImage: new NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ87rSp4-aKd1_WlQ4Mp08tHXJMQMRDN9_7u0HZp9nZanl4hOq3"),
          ),
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                data,
                style: new TextStyle(fontWeight: FontWeight.bold),
              ),
              new Text(
                date,
                style: new TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
            ],
          ),
          subtitle: new Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: new Text(
              data,
              style: new TextStyle(color: Colors.grey, fontSize: 15.0),
            ),
          ),
        )
      ],
    ));
  }
}
