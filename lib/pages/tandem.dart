import 'package:flutter/material.dart';
import 'package:cycle_up/pages/product_details.dart';
import 'package:cycle_up/components/cart_products.dart';

class TandemBike extends StatefulWidget {
  final prod_detail_name;
  final prod_detail_new_price;
  final prod_detail_old_price;
  final prod_detail_picture;
  final prod_detail_frameset;


  TandemBike({
    this.prod_detail_name,
    this.prod_detail_new_price,
    this.prod_detail_old_price,
    this.prod_detail_picture,
    this.prod_detail_frameset
  });

  @override
  _TandemState createState() => _TandemState();
}

class _TandemState extends State<TandemBike> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.2,
          backgroundColor: Colors.red,
          title: Text('Tandem'),
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {}),

          ],
        ),

        body: new ListView(
            children: <Widget>[
              Container(
                height:560.0,
                child: Similar_products(),
              ),
            ]
        )



    );
  }
}

class Similar_products extends StatefulWidget {
  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {
  var product_list = [
    {
      "name": "SD AM",
      "picture": "images/products/SD_AM.png",
      "old_price": 150,
      "price": 100,
      "frameset": "Full Cr-Mo Frame ",
    },
    {
      "name": "Cantina",
      "picture": "images/products/cantina.png",
      "old_price": 150,
      "price": 100,
      "frameset": "Full Cr-Mo Frame ",
    },
    {
      "name": "Cantina",
      "picture": "images/products/cantina.png",
      "old_price": 150,
      "price": 100,
      "frameset": "Full Cr-Mo Frame ",
    },
    {
      "name": "Cantina",
      "picture": "images/products/cantina.png",
      "old_price": 150,
      "price": 100,
      "frameset": "Full Cr-Mo Frame ",
    },

  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Similar_single_prod(
            prod_name: product_list[index]['name'],
            prod_picture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
            prod_frameset: product_list[index]['frameset'],
          );
        });
  }
}

class Similar_single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_price;
  final prod_old_price;
  final prod_frameset;

  Similar_single_prod(
      {this.prod_name,
        this.prod_picture,
        this.prod_old_price,
        this.prod_price,
        this.prod_frameset
      });


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: new Text("hero 1"),
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                // here we are passing the values of the product to the product details page
                  builder: (context) => new ProductDetails(
                    prod_detail_name: prod_name,
                    prod_detail_new_price: prod_price,
                    prod_detail_old_price: prod_old_price,
                    prod_detail_picture: prod_picture,
                    prod_detail_frameset: prod_frameset,
                  ))),
              child: GridTile(
                  footer: Container(
                      color: Colors.white70,
                      child: new Row(children: <Widget>[
                        Expanded(
                          child: Text(prod_name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                        ),
                        new Text("\Php${prod_price}", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                      ],)
                  ),
                  child: Image.asset(
                    prod_picture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }

}
