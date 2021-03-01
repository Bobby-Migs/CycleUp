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
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> new HomePage()));},
            child: Text('Cycle Up - Adding Successful')),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            model.img == null ? Icon(Icons.photo, size: 120) : Image.file(model.img, width: 100,height: 150,),
            Text(model.bikeName, style: TextStyle(fontSize: 22),),
            Text(model.price.toString(), style: TextStyle(fontSize: 22),),
            Text(model.frameset, style: TextStyle(fontSize: 22),),
            Text(model.fork, style: TextStyle(fontSize: 22),),
            Text(model.cranks, style: TextStyle(fontSize: 22),),
            Text(user.displayName, style: TextStyle(fontSize: 22),),
          ],

        ),
      ),
    );
  }
}

