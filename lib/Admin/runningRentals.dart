import 'package:cycle_up/Admin/displayRunningRentals.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/Admin/runningRentBody.dart';
import 'package:cycle_up/Admin/dashboard.dart';

class runningRentals extends StatefulWidget {

  @override
  _runningRentalsState createState() => _runningRentalsState();
}

class _runningRentalsState extends State<runningRentals> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: new AppBar(
        elevation: 0.2,
        backgroundColor: Colors.red,
        title: Text('Running Rentals'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.close),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> MyDashBoard()));
            },
          ),
        ],
        leading: new Container(),
      ),
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(0.0),
            child: new
            Text(''),
          ), //Padding

          //START OF HORIZONTAL LIST VIEW
          // HorizontalList(),
          //PADDING WIDGET
          new Padding(
            padding: const EdgeInsets.fromLTRB(4.0, 5.0, 1.0, 5.0),
           // child: new Text('Bike Listing Requests', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),

          //GRID VIEW
          Container(
            //width: MediaQuery.of(context).size.width /2,
            height: 525.0,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: MaterialButton(
                          color: Colors.white60,
                          textColor: Colors.black54,
                            onPressed: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> runningRentals()));
                            },
                        child: Text('Rented Bikes'),
                        ),
                      ),
                      //Padding(padding: EdgeInsets.all(5)),
                      Expanded(
                        child: MaterialButton(
                          color: Colors.white60,
                          textColor: Colors.black54,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> DisplayedBikes()));
                          },
                          child: Text('Displayed Bikes'),
                        ),
                      )
                    ],
                  ),

                ),
                DisplayRunningRentals()
              ],
            ),
          )
        ],
      ),
    );
  }
}


