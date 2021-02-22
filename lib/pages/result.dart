import 'package:flutter/material.dart';
import 'package:cycle_up/pages/rentalOutput.dart';
import 'dart:io';

class Rental extends StatelessWidget {
  RentalOutput model;
  File fileMedia;
  Rental({this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Successful'),
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
          ],
        ),
      ),
    );
  }
}
