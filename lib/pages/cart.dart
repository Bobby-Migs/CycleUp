import 'package:flutter/material.dart';

import 'package:cycle_up/components/cart_products.dart';

class Cart extends StatefulWidget {
  final cart_detail_name;
  final cart_detail_old_price;
  final cart_detail_picture;
  final cart_detail_total;
  final cart_type;

  Cart({
    this.cart_detail_name,
    this.cart_detail_old_price,
    this.cart_detail_picture,
    this.cart_detail_total,
    this.cart_type,

  });

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.2,
        backgroundColor: Colors.red,
        title: Text('cart'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),

        ],
      ),

      body: InkWell(
          onTap: () {},
          child: new Cart_products()),

      bottomNavigationBar: new Container(
          color: Colors.white,
          child: Row(
              children: <Widget>[
                // Expanded(child: ListTile(
                //   title: new Text("Total:"),
                //   subtitle: new Text("Php250"),
                // )),
                // Expanded(
                //     child: new MaterialButton(onPressed: () {},
                //       child: new Text(
                //         "Check out", style: TextStyle(color: Colors.white),),
                //       color: Colors.red,)
                // )


              ]
          )
      ),
    );
  }
}
