import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/components/databaseManager.dart';
import 'package:cycle_up/pages/product_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}



class _Cart_productsState extends State<Cart_products> {
  List userCartList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await databaseManager().getCartList();

    if(resultant == null){
      print('Unable to retrieve');
    }else {
      setState(() {
        userCartList = resultant;
      });
    }
  }
  get index => null;

  @override
  Widget build(BuildContext context) {


    return new ListView.builder(
        itemCount: userCartList.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_prod_name: userCartList[index]["bikeName"],
            cart_prod_picture: userCartList[index]["picture"],
            cart_prod_price: userCartList[index]["price"],
            cart_prod_frameset: userCartList[index]["frameset"],
            cart_prod_fork: userCartList[index]["fork"],
            cart_prod_cranks: userCartList[index]["cranks"],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_frameset;
  final cart_prod_fork;
  final cart_prod_cranks;


  Single_cart_product(
      {this.cart_prod_name,
      this.cart_prod_picture,
      this.cart_prod_price,
      this.cart_prod_frameset,
      this.cart_prod_fork,
      this.cart_prod_cranks,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(
        // here we are passing the values of the cartList to the product details page
        builder: (context) => new ProductDetails(
          prod_detail_name: cart_prod_name,
          prod_detail_new_price: cart_prod_price,
          prod_detail_picture: cart_prod_picture,
          prod_detail_frameset: cart_prod_frameset,
          prod_detail_cranks: cart_prod_cranks,
          prod_detail_fork: cart_prod_fork,
        ),
      )),
      child: Card(
        child: ListTile(
          // <<<<<<<<<<<< LEADING SECTION >>>>>>>>>>>>>
          leading: new Image.network(cart_prod_picture, width: 80.0, height: 80.0,),

          // <<<<<<<<<<<<< TITLE SECTION >>>>>>>>>>>>
          title: new Text(cart_prod_name),

          //<<<<<<<<<<<<< SUBTITLE SECTION >>>>>>>>>>
          subtitle: new Column(
            children: <Widget>[

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
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(2.0),
                child: new Text("Owner: "+user.displayName),
              ),

            ],
          ),
        ),


      ),

    );
  }
}
