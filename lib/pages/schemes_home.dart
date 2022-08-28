import 'package:flutter/material.dart';
import 'package:pop/pages/scheme.dart';

class SchemeHome extends StatefulWidget {
  @override
  _SchemeHomeState createState() => _SchemeHomeState();
}

class _SchemeHomeState extends State<SchemeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Products(),
    ));
  }
}

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final list_item = [
    {"name": "Soil", "pic": "assets/img/1.jpg"},
    {"name": "Seeds", "pic": "assets/img/2.jpg"},
    {"name": "Irrigation", "pic": "assets/img/3.jpg"},
    {"name": "Horticulture", "pic": "assets/img/4.jpg"},
    {"name": "Fertilizer", "pic": "assets/img/5.jpg"},
    {"name": "Machinery ", "pic": "assets/img/6.jpg"},
    {"name": "Irrigation22", "pic": "assets/img/1.jpg"},
    {"name": "Horticulture33", "pic": "assets/img/1.jpg"}
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: list_item.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Product(list_item[index]['name'], list_item[index]['pic']);
      },
    );
  }
}

class Product extends StatelessWidget {
  final product_name;
  final product_pic;
  Product(this.product_name, this.product_pic);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Hero(
            tag: product_name,
            child: Material(
                child: InkWell(
              onTap: () {
                print("$product_name presses");

                Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => Scheme(product_name)),
                );
              },
              child: GridTile(
                // child: Container(
                //   height: 130,
                //   width: 130,
                //   decoration: BoxDecoration(
                //       // backgroundBlendMode: true,
                //       image: DecorationImage(
                //           image: AssetImage('assets/$product_pic'),
                //           fit: BoxFit.fill),
                //       borderRadius: BorderRadius.circular(100),
                //       border: Border.all(
                //           color: Colors.blueAccent.withOpacity(.5),
                //           width: 1)),
                // ),
                child: Image.asset(
                  product_pic,
                  fit: BoxFit.cover,
                ),
                footer: Container(
                  height: 50,
                  color: Colors.black38,
                  child: ListTile(
                      title: Text(
                    product_name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18.0),
                  )),
                ),
              ),
            ))));
  }
}
