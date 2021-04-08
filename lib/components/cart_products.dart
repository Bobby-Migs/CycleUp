import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/components/databaseManager.dart';
import 'package:cycle_up/pages/product_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cycle_up/pages/cart.dart';

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
            cart_prod_feature: userCartList[index]["features"],
            ctrId: userCartList[index]["cartID"],
            ownerEmail: userCartList[index]["ownerEmail"],
            user_Name: userCartList[index]['ownerName'],

          );
        });
  }
}

class Single_cart_product extends StatefulWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_frameset;
  final cart_prod_fork;
  final cart_prod_cranks;
  final cart_prod_feature;
  final ctrId;
  final ownerEmail;
  final user_Name;
  Single_cart_product(
      {this.cart_prod_name,
      this.cart_prod_picture,
      this.cart_prod_price,
      this.cart_prod_frameset,
      this.cart_prod_fork,
      this.cart_prod_cranks,
      this.cart_prod_feature,
      this.ctrId,
        this.ownerEmail,
        this.user_Name
      });

  @override
  _Single_cart_productState createState() => _Single_cart_productState();
}

class _Single_cart_productState extends State<Single_cart_product> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(
        // here we are passing the values of the cartList to the product details page
        builder: (context) => new ProductDetails(
          prod_detail_name: widget.cart_prod_name,
          prod_detail_new_price: widget.cart_prod_price,
          prod_detail_picture: widget.cart_prod_picture,
          prod_detail_frameset: widget.cart_prod_frameset,
          prod_detail_cranks: widget.cart_prod_cranks,
          prod_detail_fork: widget.cart_prod_fork,
          cart_id: widget.ctrId.toString(),
          prod_detail_features: widget.cart_prod_feature,
          ownerEmail: widget.ownerEmail,
          user_Name: widget.user_Name,

        ),
      )),
      child: Card(
        child: ListTile(
          // <<<<<<<<<<<< LEADING SECTION >>>>>>>>>>>>>
          leading: new Image.network(widget.cart_prod_picture, width: 80.0, height: 80.0,),

          // <<<<<<<<<<<<< TITLE SECTION >>>>>>>>>>>>
          title: Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width /3,
                  child: Text(widget.cart_prod_name)),
              Container(
                child: MaterialButton(
                    child: Text('Remove', style: TextStyle(color: Colors.red),),
                    onPressed: (){
                      databaseManager().deleteUser(this.widget.ctrId);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()));
                    }),
              )
            ],
          ),

          //<<<<<<<<<<<<< SUBTITLE SECTION >>>>>>>>>>
          subtitle: new Column(
            children: <Widget>[

              //<<<<<<<<<<<<< THIS SECTION IS FOR THE RENTAL PRICE >>>>>>>>>>>>>>>>
              new Container(
                alignment: Alignment.topLeft,
                child: new Text(
                  "\Php${widget.cart_prod_price}",
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
