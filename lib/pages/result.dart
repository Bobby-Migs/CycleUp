import 'package:flutter/material.dart';
import 'package:cycle_up/pages/rentalOutput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
import 'package:cycle_up/pages/home.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rental extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  RentalOutput model;
  File fileMedia;
  Rental({this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: (){},
            child: Text('Listing Details')),
      ),
      body: Container(

        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: model.img == null ? Icon(Icons.photo, size: 120) : Image.file(model.img, width: 250,height: 300,)
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width /2.5,
                  child: Text('BIKE NAME:', style: TextStyle(fontSize: 22),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width /3,
                  child: Text(model.bikeName),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width /2.5,
                  child: Text('BIKE PRICE:', style: TextStyle(fontSize: 22),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width /3,
                  child:Text(model.price.toString()),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width /2.5,
                  child: Text('FRAMESET:', style: TextStyle(fontSize: 22),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width /3,
                  child:Text(model.frameset),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width /2.5,
                  child: Text('FORK:', style: TextStyle(fontSize: 22),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width /3,
                  child:Text(model.fork),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width /2.5,
                  child: Text('CRANKS:', style: TextStyle(fontSize: 22),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width /3,
                  child:Text(model.cranks),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width /2.5,
                  child: Text('OWNER:', style: TextStyle(fontSize: 22),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width /3,
                  child: Text(user.displayName),
                ),
              ],
            ),
            Spacer(),
            Divider(),

            Center(
              child: RaisedButton(
                color: Colors.red,
                child: Text('Confirm',
                    style: TextStyle(
                        color: Colors.white
                    ),),
                  onPressed: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                    //Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
                    //Navigator.popUntil(context, ModalRoute.withName('/HomePage'));
                    //Navigator.of(context).pop(context);
                    for(int x= 0; x < 5-1; x++ ){
                      Navigator.of(context).pop(context);
                    }
              }),
            )

          ],

        ),
      ),
    );
  }
}

