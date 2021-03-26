
import 'package:cycle_up/provider/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:cycle_up/Admin/RentalListNav.dart';
import 'package:cycle_up/pages/login.dart';

//my own imports
import 'package:cycle_up/Admin/body.dart';
import 'package:cycle_up/Admin/runningRentals.dart';

import 'package:provider/provider.dart';

class MyDashBoard extends StatefulWidget {

  @override
  _MyDashBoardState createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  final user = FirebaseAuth.instance.currentUser;
  final googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: new AppBar(
        elevation: 0.2,
        backgroundColor: Colors.red,
        title: Text('Cycle Up - Administrator'),
        actions: <Widget>[
          // new IconButton(
          //     icon: Icon(
          //       Icons.search,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       showSearch(context: context, delegate: ProductsSearch());
          //     }),
          // new IconButton(
          //     icon: Icon(
          //       Icons.shopping_cart,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart()));
          //     })

        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //  header
            new UserAccountsDrawerHeader(
              accountName: Text(
                'Admin:' + user.displayName,
              ),
              accountEmail: Text(
                'Email: ' + user.email,
                style: TextStyle(color: Colors.white),
              ),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  maxRadius: 25,
                  backgroundImage: NetworkImage(user.photoURL),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.red),
            ),
            //  body

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyDashBoard()));
                // Navigator.of(context).pop(context);
              },
              child: ListTile(
                title: Text('Dashboard'),
                leading: Icon(Icons.home, color: Colors.red),
              ),
            ),

            InkWell(

              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> RentalListHome()));
              },
              child: ListTile(
                title: Text('Bike Rentals'),
                leading: Icon(Icons.directions_bike, color: Colors.red),
              ),
            ),

            InkWell(
              onTap: () {
               // Navigator.push(context, MaterialPageRoute(builder: (context)=> new Rentals()));
              },
              child: ListTile(
                title: Text('User Accounts'),
                leading: Icon(Icons.account_circle_rounded, color: Colors.red),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> runningRentals()));
              },
              child: ListTile(
                title: Text('Running Rentals'),
                leading: Icon(Icons.storage, color: Colors.red),
              ),
            ),


            Divider(),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help),
              ),
            ),

            InkWell(
              onTap: () {
                logout();
              },
              child: ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.logout),

              ),
            ),

          ],
        ),
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
            child: new Text('Bike Listing Requests', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),

          //GRID VIEW
          Container(
            height: 525.0,
            child: Body(),
          )
        ],
      ),
    );
  }
  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }
}


