import 'package:cycle_up/components/databaseManager.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/pages/product_details.dart';
import 'package:cycle_up/pages/home.dart';
import 'package:cycle_up/components/databaseManager.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body> {
  List userProductList = [];


  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await databaseManager().getUsersList();

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
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisExtent: 125),
        itemBuilder: (BuildContext context, int index) {
          return Single_prod(
            prod_name: userProductList[index]['bikeName'],
            prod_picture: userProductList[index]['picture'],
            prod_price: userProductList[index]['price'],
            prod_frameset: userProductList[index]['frameset'],
            prod_cranks: userProductList[index]['cranks'],
            prod_fork: userProductList[index]['fork'],
            prod_features: userProductList[index]['features'],
            prod_userName: userProductList[index]['userName'],
            prod_userEmail: userProductList[index]['userEmail'],

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
  final prod_userEmail;
  final prod_userName;

  Single_prod(
      {this.prod_name,
        this.prod_picture,
        this.prod_old_price,
        this.prod_price,
        this.prod_frameset,
        this.prod_cranks,
        this.prod_fork,
        this.prod_features,
        this.prod_userEmail,
        this.prod_userName,
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

                ),
              )),
              child: Card (
                  child: ListTile(
                    // <<<<<<<<<<<< LEADING SECTION >>>>>>>>>>>>>
                    //leading: new Image.network(cart_prod_picture, width: 80.0, height: 80.0,),

                    // <<<<<<<<<<<<< TITLE SECTION >>>>>>>>>>>>
                    title: Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width /3,
                            child: Text(prod_userName)),
                        Container(
                          child: MaterialButton(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(60,10,0,0),
                                child: Text('View Details', style: TextStyle(color: Colors.red,),),
                              ),
                              onPressed: (){
                                //databaseManager().deleteUser(this.ctrId);
                               // Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()));
                              }),
                        )
                      ],
                    ),

                    //<<<<<<<<<<<<< SUBTITLE SECTION >>>>>>>>>>
                    subtitle: new Column(
                      children: <Widget>[

                        //<<<<<<<<<<<<< THIS SECTION IS FOR THE RENTAL PRICE >>>>>>>>>>>>>>>>
                        new Container(
                          alignment: Alignment.topLeft,
                          child: new Text(
                            prod_userEmail,
                            style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                ),

                //Image.network(prod_picture),
                // Image.asset
                //   ('images/products/cantina.png', fit: BoxFit.cover,),
              ),
            ),

          )),
    );
  }

}

class ProdItem{

  final String name;
  final String category;
  ProdItem({
    this.name,
    this.category,
  });
}
List<ProdItem> loadProdItem(){


  var fi = <ProdItem>[
    ProdItem(
      name: "SD AM",
      category: "BMX",
    ),
    ProdItem(
      name: "Cantina",
      category: "Road bike",
    ),
    ProdItem(
      name: "Leucadia",
      category: "BMX",
    ),
    ProdItem(
      name: "Shredder_18",
      category: "road bike",
    ),
  ];
  return fi;
}


