import 'package:cycle_up/provider/google_sign_in.dart';
import 'package:cycle_up/widget/sign_up_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cycle_up/pages/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

//my own imports
import 'package:cycle_up/components/horizontal_listview.dart';
import 'package:cycle_up/components/products.dart';
import 'package:cycle_up/pages/cart.dart';
import 'package:cycle_up/pages/myRentals.dart';

//trial
//import 'package:cycle_up/widget/logged_in_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(context: context, delegate: ProductsSearch());
              }),
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> new HomePage()));
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=> new Rentals()));
              },
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

            InkWell(
              onTap: () {

                //Navigator.push(context, MaterialPageRoute(builder: (context)=> new SignUpWidget()));
                final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
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
          //START OF IMAGE CAROUSEL
          imageCarousel,
          //PADDING WIDGET
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
            child: new Text('Bike Collections'),
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

void logout() async {
  await googleSignIn.disconnect();
  FirebaseAuth.instance.signOut();
}
}



class ProductsSearch extends SearchDelegate<Single_prod>{

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query="";
    },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: Icon(Icons.arrow_back),);
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   final mylist = query.isEmpty? loadProdItem() 
       : loadProdItem().where((p)=> p.name.startsWith(query)).toList();
   return mylist.isEmpty? Text("No Results Found...."): ListView.builder(
       itemCount: mylist.length,
       itemBuilder: (context, index){
         final ProdItem fi = mylist[index];
         return ListTile(title:Text(fi.name),);
       });
  }

}
