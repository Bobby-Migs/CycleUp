import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}



class _Cart_productsState extends State<Cart_products> {


  var Products_on_the_cart = [
    {
      "name": "SD AM",
      "picture": "images/products/cantina.png",
      "price": 100,
      "quantity": 1,
      "hour": 3,
      "date": "02/18/21",
    },
    {
      "name": "Cantina",
      "picture": "images/products/cantina.png",
      "price": 150,
      "quantity": 2,
      "hour": 2,
      "date": "02/18/21",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: Products_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_prod_name: Products_on_the_cart[index]["name"],
            cart_prod_hour: Products_on_the_cart[index]["hour"],
            cart_prod_picture: Products_on_the_cart[index]["picture"],
            cart_prod_price: Products_on_the_cart[index]["price"],
            cart_prod_quantity: Products_on_the_cart[index]["quantity"],
            cart_prod_date: Products_on_the_cart[index]["date"],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_hour;
  final cart_prod_date;
  final cart_prod_quantity;

  Single_cart_product(
      {this.cart_prod_name,
      this.cart_prod_picture,
      this.cart_prod_price,
      this.cart_prod_hour,
      this.cart_prod_date,
      this.cart_prod_quantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // <<<<<<<<<<<< LEADING SECTION >>>>>>>>>>>>>
        leading: new Image.asset(cart_prod_picture, width: 80.0, height: 80.0,),

        // <<<<<<<<<<<<< TITLE SECTION >>>>>>>>>>>>
        title: new Text(cart_prod_name),

        //<<<<<<<<<<<<< SUBTITLE SECTION >>>>>>>>>>
        subtitle: new Column(
          children: <Widget>[
            // ROW INSIDE THE COLUMN
            new Row(
              children: <Widget>[
                // this section is for the hours of rental
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: new Text("Hour:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(
                    "\ ${cart_prod_hour}hr",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                //<<<<<<<<<<<<<< THIS SECTION IS FOR DATE OF RENTAL >>>>>>>>>>>>>>>>>>>>>>
                new Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                  child: new Text("Date:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(
                    cart_prod_date,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            //<<<<<<<<<<<<< THIS SECTION IS FOR THE RENTAL PRICE >>>>>>>>>>>>>>>>
            new Container(
              alignment: Alignment.topLeft,
              child: new Text(
                "\Php${cart_prod_price}",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        // trailing: new Column(
        //   children: <Widget>[
        //     new IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: null),
        //     new Text("$cart_prod_quantity"),
        //     new IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: null)
        //   ],
        // ),
      ),


    );
  }
}
