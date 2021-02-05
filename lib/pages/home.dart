import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

//my own imports
import 'package:cycle_up/components/horizontal_listview.dart';
import 'package:cycle_up/components/products.dart';
import 'package:cycle_up/pages/cart.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
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
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
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
              accountName: Text('Santos Miguel'),
              accountEmail: Text('rionjumiguel@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.red),
            ),
            //  body

            InkWell(
              onTap: () {},
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
              onTap: () {},
              child: ListTile(
                title: Text('My Rentals'),
                leading: Icon(Icons.directions_bike_outlined, color: Colors.red),
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
              onTap: () {},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help),
              ),
            ),
          ],
        ),
      ),
      body: new ListView(
        children: <Widget>[
          //START OF IMAGE CAROUSEL
          image_carousel,
          //PADDING WIDGET
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text('Categories'),
          ), //Padding

          //START OF HORIZONTAL LIST VIEW
          HorizontalList(),
          //PADDING WIDGET
          new Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Text('Recent Bikes'),
          ),

          //GRID VIEW
          Container(
            height: 320.0,
            child: Products(),
          )
        ],
      ),
    );
  }
}
