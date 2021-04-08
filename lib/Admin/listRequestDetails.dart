import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/components/databaseManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cycle_up/Admin/dashboard.dart';
import '../components/cart_products.dart';

class RequestDetails extends StatefulWidget {
  final prod_detail_name;
  final prod_detail_new_price;
  final prod_detail_cranks;
  final prod_detail_picture;
  final prod_detail_frameset;
  final prod_detail_features;
  // final prod_detail_total;
  // final prod_detail_date;
  // final prod_type;
   final prod_detail_fork;
  // final cart_id;
   final user_Name;
   final user_Email;
   final listID;


  RequestDetails({
    this.prod_detail_name,
    this.prod_detail_new_price,
    this.prod_detail_cranks,
    this.prod_detail_picture,
    this.prod_detail_frameset,
    this.prod_detail_features,
    // this.prod_detail_total,
    // this.prod_detail_date,
    // this.prod_type,
     this.prod_detail_fork,
    // this.cart_id,
    this.user_Name,
    this.user_Email,
    this.listID
  });

  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  Widget build(BuildContext context) {
    Future createProduct(String userName, String userEmail, String _image, String bikeName, int price, String frameset, String fork, String cranks, String features, String bikeID) async {
      await databaseManager().pushBikeCollections(userName, userEmail, _image, bikeName, price, frameset, fork, cranks, features, bikeID);
    }
    Future sendNotif(String ownerName, String borrowerName, String bikeName, String message, DateTime selectedDated, DateTime rentalDueDate) async {
      await databaseManager().pushToNotification(ownerName, borrowerName, bikeName, message, selectedDated,rentalDueDate);
    }
    Future pushToDisplay(String userName, String userEmail, String _image, String bikeName, int price, String frameset, String fork, String cranks, String features, String ID) async {
      await databaseManager().pustToDisplay(userName, userEmail, _image, bikeName, price, frameset, fork, cranks, features, ID);
    }
    String notifMessage= "Mr/Ms. ${widget.user_Name} your request to list your bike ${widget.prod_detail_name} has been permitted. Your bike will be now available for rental.";
    String displayID = FirebaseFirestore.instance.collection("displayedBikes").doc().id;
    String bikeID = FirebaseFirestore.instance.collection("bikeCollections").doc().id;

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: InkWell(
            onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=> new HomePage()));
              Navigator.of(context).pop(context);
            },
            child: Text('Request Details')),
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
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.network(widget.prod_detail_picture, fit: BoxFit.cover,),
              ),
              footer: new Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text(
                    widget.prod_detail_name,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                          child: new Text(
                            "\Php${widget.prod_detail_new_price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // ======== the first buttons ===========
          Row(
            children: <Widget>[
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text('Owner: '+widget.user_Name),
          ),

          Divider(),
          new ListTile(
            title: new Text("FEATURES"),
            subtitle: new Text(widget.prod_detail_features),
          ),
          Divider(),
          new ListTile(
            title: new Text("SPECIFICATION"),
          ),
          new Row(
              children: <Widget>[
                Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text("FRAMESET",style: TextStyle(color: Colors.grey),),),
                Padding(padding: EdgeInsets.all(5.0),
                  child: new Text(widget.prod_detail_frameset),
                ),
              ]
          ),

          new Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text("FORK",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.prod_detail_fork),
              ),
            ],
          ),

          new Row(
              children: <Widget>[
                Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text("CRANKS",style: TextStyle(color: Colors.grey),),),
                Padding(padding: EdgeInsets.all(5.0),
                  child: new Text(widget.prod_detail_cranks),
                )
              ]
          ),
          Divider(),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: new Text("Similar Bikes"),
          // ),
          //SIMILAR PRODUCTS SECTION
            MaterialButton(
              onPressed: (){
                createProduct(widget.user_Name, widget.user_Email, widget.prod_detail_picture, widget.prod_detail_name,
                    widget.prod_detail_new_price, widget.prod_detail_frameset, widget.prod_detail_fork, widget.prod_detail_cranks, widget.prod_detail_features, bikeID);
                //SENDS THE NOTIFICATION TO DATABASE AND TO THE OWNER
                sendNotif(widget.user_Name, "",  widget.prod_detail_name, notifMessage, DateTime.now(), DateTime.now());
                databaseManager().deleteListingReq(widget.listID);

                pushToDisplay(widget.user_Name, widget.user_Email, widget.prod_detail_picture, widget.prod_detail_name, widget.prod_detail_new_price,
                    widget.prod_detail_frameset, widget.prod_detail_fork, widget.prod_detail_cranks, widget.prod_detail_features, displayID);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyDashBoard()));

              },
              color: Colors.red,
              textColor: Colors.white,
              elevation: 0.2,
              child: Text('Allow and Push Request'),
            ),
            //Similar_products(),
        ],
      ),
    );
  }
}
