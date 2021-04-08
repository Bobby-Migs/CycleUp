import 'package:cycle_up/provider/google_sign_in.dart';
import 'package:cycle_up/widget/sign_up_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cycle_up/pages/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cycle_up/About/aboutPage.dart';

//my own imports
import 'package:cycle_up/components/horizontal_listview.dart';
import 'package:cycle_up/Renter_Page/RentProducts.dart';
import 'package:cycle_up/pages/cart.dart';
import 'package:cycle_up/pages/myRentals.dart';
import 'package:provider/provider.dart';


class RentHomePage extends StatefulWidget {

  @override
  _RentHomePageState createState() => _RentHomePageState();
}

class _RentHomePageState extends State<RentHomePage> {
  final user = FirebaseAuth.instance.currentUser;
  final googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/bannerImg1.jpg'),
          AssetImage('images/bannerImg2.jpg'),
          AssetImage('images/bannerImg3.jpg'),
        ],
        autoplay: false,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 6.0,
        dotBgColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.2,
        backgroundColor: Colors.red,
        title: Text('Cycle Up'),
        actions: <Widget>[
          // new IconButton(
          //     icon: Icon(
          //       Icons.search,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       showSearch(context: context, delegate: ProductsSearch());
          //     }),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart()));
              })
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //  header
            new UserAccountsDrawerHeader(
              accountName: Text(
                'Name: ' + user.displayName,
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> new RentHomePage()));

              },
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home, color: Colors.red),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My account'),
                leading: Icon(Icons.person, color: Colors.red),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart()));

              },
              child: ListTile(
                title: Text('My Cart'),
                leading: Icon(Icons.shopping_cart, color: Colors.red),
              ),
            ),

            Divider(),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutPage()));
              },
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help),
              ),
            ),

            InkWell(
              onTap: () {

                //Navigator.push(context, MaterialPageRoute(builder: (context)=> new SignUpWidget()));
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: new ListView(
          children: <Widget>[
            //START OF IMAGE CAROUSEL
            imageCarousel, //Padding

            //START OF HORIZONTAL LIST VIEW
            // HorizontalList(),
            //PADDING WIDGET
            new Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 10.0, 1.0, 5.0),
              child: new Text('Bike Collections'),
            ),

            //GRID VIEW
            Container(
              height: MediaQuery.of(context).size.height/1.9,
              child: Products(),
            )
          ],
        ),
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

