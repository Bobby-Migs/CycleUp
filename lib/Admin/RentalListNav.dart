import 'package:flutter/material.dart';
import 'package:cycle_up/Admin/RentalLists.dart';

class RentalListHome extends StatefulWidget {

  @override
  _RentalListHomeState createState() => _RentalListHomeState();
}

class _RentalListHomeState extends State<RentalListHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.2,
        backgroundColor: Colors.red,
        title: InkWell(
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context)=> new HomePage()));
              Navigator.of(context).pop(context);
            },
            child: Text('Rental Lists')),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),

        ],
      ),

      body: new RentalLists(),

    );
  }
}