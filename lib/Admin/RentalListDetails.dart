import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/components/databaseManager.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/cart_products.dart';

class RentalListDetails extends StatefulWidget {
  final prod_name;
  final prod_picture;
  final prod_price;
  final ownerName;
  final borrowerName;
  final userEmail;
  final address;
  final contactNum;
  final dayHr;
  final type;
  final borrowerDocID;


  RentalListDetails({
    this.prod_name,
    this.prod_picture,
    this.prod_price,
    this.ownerName,
    this.borrowerName,
    this.userEmail,
    this.address,
    this.contactNum,
    this.dayHr,
    this.type,
    this.borrowerDocID
  });

  @override
  _RentalListDetailsState createState() => _RentalListDetailsState();
}

class _RentalListDetailsState extends State<RentalListDetails> {
  DateTime selectedDate = DateTime.now();
  final f = new DateFormat('yyyy-MM-dd');
  var rentalDueDate;

  @override
  Widget build(BuildContext context) {
    String runningRentalID = FirebaseFirestore.instance.collection("runningRentals").doc().id;


    Future createRentalList(String image, String ownerName, String userName, String userEmail, String contNum, String address, String bikeName, int price, DateTime selectedDate, ) async {
      await databaseManager().pushToRentalRequest(image, ownerName, userName, userEmail, contNum, address, bikeName, price, selectedDate, );
    }
    Future sendNotif(String ownerName, String borrowerName, String bikeName, String message, DateTime selectedDated, DateTime rentalDueDate) async {
      await databaseManager().pushToNotification(ownerName, borrowerName, bikeName, message, selectedDated,rentalDueDate);
    }
    Future runningRentals(String image, String ownerName, String userName, String userEmail, String contNum, String address, String bikeName, int price, DateTime selectedDate, int days, String type, String ID) async {
      await databaseManager().pushToRunningRentals(image, ownerName, userName, userEmail, contNum, address, bikeName, price, selectedDate, days, type, ID );
    }

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
                child: Image.network(widget.prod_picture, fit: BoxFit.cover,),
              ),
              footer: new Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text(
                    widget.prod_name,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                          child: new Text(
                            "\Php${widget.prod_price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          )),
                      Text('Today: '+f.format(selectedDate)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // ======== the first buttons ===========
          Divider(),
          new ListTile(
            title: new Text("OWNER: "),
            subtitle: new Text(widget.ownerName),
          ),

          Divider(),
          new ListTile(
            title: new Text("BORROWER: "),
            subtitle: new Text(widget.borrowerName),
          ),
          Divider(),

          MaterialButton(
            onPressed: (){
              if(widget.type=="Day"){
                var today = DateTime.now();
                 rentalDueDate = today.add(Duration(days: widget.dayHr));
              }else{
                var today = DateTime.now();
                 rentalDueDate = today.add(Duration(hours: widget.dayHr));
              }
              String notifMessage= "Cycle Up - Your bike ${widget.prod_name} has been rented by ${widget.borrowerName} you will be notified when the rental time of the borrower has expired\n "+
                  "Rental Info: ${widget.dayHr} ${widget.type}\n"
                      "Starting Date: ${selectedDate.toString()}\n""Due to: $rentalDueDate";

              //SENDS THE RENTAL INFO TO  DATABASE
              createRentalList(widget.prod_picture, widget.ownerName, widget.borrowerName, widget.userEmail,
                  widget.contactNum, widget.address, widget.prod_name,widget.prod_price,selectedDate);
              //SENDS THE NOTIFICATION TO DATABASE AND TO THE OWNER
              sendNotif(widget.ownerName, widget.borrowerName,  widget.prod_name, notifMessage, selectedDate, rentalDueDate);

              runningRentals(widget.prod_picture, widget.ownerName, widget.borrowerName, widget.userEmail, widget.contactNum,
                  widget.address,  widget.prod_name, widget.prod_price, selectedDate, widget.dayHr, widget.type, runningRentalID);
            },

            color: Colors.red,
            textColor: Colors.white,
            elevation: 0.2,
            child: Text('Allow Start Rental Request'),
          ),
          //Similar_products(),
        ],
      ),
    );
  }
}
