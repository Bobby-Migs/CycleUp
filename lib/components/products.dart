import 'package:flutter/material.dart';
import 'package:cycle_up/pages/product_details.dart';
import 'package:cycle_up/pages/home.dart';

class Products extends StatefulWidget {


  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "SD AM",
      "picture": "images/products/SD_AM.png",
      "old_price": 150,
      "price": 100,
      "frameset": "Full Cr-Mo Frame ",
    },
    {
      "name": "Cantina",
      "picture": "images/products/cantina.png",
      "old_price": 150,
      "price": 100,
      "frameset": "Full Cr-Mo Frame ",
    },
    {
      "name": "Cantina",
      "picture": "images/products/cantina.png",
      "old_price": 150,
      "price": 100,
      "frameset": "Full Cr-Mo Frame ",
    },
    {
      "name": "Cantina",
      "picture": "images/products/cantina.png",
      "old_price": 150,
      "price": 100,
      "frameset": "Full Cr-Mo Frame ",
    },
    {
      "name": "Cantina",
      "picture": "images/products/cantina.png",
      "old_price": 150,
      "price": 100,
      "frameset": "Full Cr-Mo Frame ",
    },
    {
      "name": "Cantina",
      "picture": "images/products/cantina.png",
      "old_price": 150,
      "price": 100,
      "frameset": "Full Cr-Mo Frame ",
    },

  ];

  get index => null;


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Single_prod(
            prod_name: product_list[index]['name'],
            prod_picture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
            prod_frameset: product_list[index]['frameset'],
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

  Single_prod(
      {this.prod_name,
      this.prod_picture,
      this.prod_old_price,
      this.prod_price,
      this.prod_frameset
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
                    prod_detail_old_price: prod_old_price,
                    prod_detail_picture: prod_picture,
                    prod_detail_frameset: prod_frameset,
                  ),
              )),
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: new Row(children: <Widget>[
                      Expanded(
                          child: Text(prod_name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                      ),
                      new Text("\Php${prod_price}", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                    ],)
                  ),
                  child: Image.asset(
                    prod_picture,
                    fit: BoxFit.cover,
                  ),
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


