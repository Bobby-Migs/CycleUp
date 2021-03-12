import 'package:flutter/material.dart';
import 'package:cycle_up/pages/home.dart';
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
        title: InkWell(
            onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=> new HomePage()));
              Navigator.of(context).pop(context);
            },
            child: Text('Cart')),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),

        ],
      ),

      body: new Cart_products(),

    );
  }
}
