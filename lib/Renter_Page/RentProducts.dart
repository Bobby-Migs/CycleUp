import 'package:cycle_up/components/databaseManager.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/Renter_Page/RentalPage.dart';
import 'package:cycle_up/pages/home.dart';
import 'package:cycle_up/components/databaseManager.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}


class _ProductsState extends State<Products> {
  List userProductList = [];


  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await databaseManager().getBikeCollections();

    if(resultant == null){
      print('Unable to retrieve');
    }else {
      setState(() {
        userProductList = resultant;
      });
    }
  }


  get index => null;


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: userProductList.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Single_prod(
            prod_name: userProductList[index]['bikeName'],
            prod_picture: userProductList[index]['picture'],
            prod_price: userProductList[index]['price'],
            prod_frameset: userProductList[index]['frameset'],
            prod_cranks: userProductList[index]['cranks'],
            prod_fork: userProductList[index]['fork'],
            prod_features: userProductList[index]['features'],
            user_Name: userProductList[index]['userName'],
            ownerEmail: userProductList[index]['userEmail'],

          );
        });
  }

}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_price;
  final prod_old_price;
  final prod_frameset;
  final prod_cranks;
  final prod_fork;
  final prod_features;
  final user_Name;
  final ownerEmail;

  Single_prod(
      {this.prod_name,
        this.prod_picture,
        this.prod_old_price,
        this.prod_price,
        this.prod_frameset,
        this.prod_cranks,
        this.prod_fork,
        this.prod_features,
        this.user_Name,
        this.ownerEmail,
      });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: new Text("hero 1"),
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                // here we are passing the values of the product to the product details page
                builder: (context) => new ProductDetails(
                  prod_detail_name: prod_name,
                  prod_detail_new_price: prod_price,
                  prod_detail_picture: prod_picture,
                  prod_detail_frameset: prod_frameset,
                  prod_detail_cranks: prod_cranks,
                  prod_detail_fork: prod_fork,
                  prod_detail_features: prod_features,
                  user_Name: user_Name,
                  ownerEmail: ownerEmail,



                ),
              )),
              child: GridTile (
                footer: Container(
                    color: Colors.white70,
                    child: new Row(children: <Widget>[
                      Expanded(
                        child: Text(prod_name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                      ),
                      new Text("\Php${prod_price}", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                    ],)
                ),
                child:Image.network(prod_picture),
                // Image.asset
                //   ('images/products/cantina.png', fit: BoxFit.cover,),
              ),
            ),

          )),
    );
  }

}

