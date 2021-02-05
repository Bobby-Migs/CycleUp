import 'package:cycle_up/components/horizontal_listview.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/main.dart';
import 'package:cycle_up/pages/home.dart';

class ProductDetails extends StatefulWidget {
  final prod_detail_name;
  final prod_detail_new_price;
  final prod_detail_old_price;
  final prod_detail_picture;
  final prod_detail_frameset;

  ProductDetails({this.prod_detail_name,
    this.prod_detail_new_price,
    this.prod_detail_old_price,
    this.prod_detail_picture,
    this.prod_detail_frameset
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: InkWell(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> new HomePage()));},
            child: Text('Cycle Up')),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.prod_detail_picture),
              ),
              footer: new Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text(
                    widget.prod_detail_name,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                          child: new Text(
                            "${widget.prod_detail_old_price}",
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          )),
                      Expanded(
                          child: new Text(
                            "\$${widget.prod_detail_new_price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // ======== the first buttons ===========
          Row(
            children: <Widget>[
              //<<<<<<<<<<<<<<< the day button >>>>>>>>>>>>
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context) {
                      return new AlertDialog(
                        title: new Text("Date"),
                        content: new Text("Choose Date"),
                        actions: <Widget>[
                          new MaterialButton(onPressed: (){
                            Navigator.of(context).pop(context);
                          },
                          child: new Text("close"),)
                        ],
                      );
                    });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(children: <Widget>[
                    Expanded(child: new Text("Date")),
                    Expanded(child: new Icon(Icons.arrow_drop_down)),
                  ]),
                ),
              ),

              //<<<<<<<<<<<<<<< the hour button >>>>>>>>>>>>
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context) {
                      return new AlertDialog(
                        title: new Text("Hour"),
                        content: new Text("Choose hours of rental"),
                        actions: <Widget>[
                          new MaterialButton(onPressed: (){
                            Navigator.of(context).pop(context);
                          },
                            child: new Text("close"),)
                        ],
                      );
                    });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(children: <Widget>[
                    Expanded(child: new Text("Hour")),
                    Expanded(child: new Icon(Icons.arrow_drop_down)),
                  ]),
                ),
              ),
              //<<<<<<<<<<<<<<< the size button >>>>>>>>>>>>

              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context){
                      return new AlertDialog(
                        title: new Text("Quantity"),
                        content: new Text("Select Quantity"),
                        actions: <Widget>[
                          new MaterialButton(onPressed: (){
                            Navigator.of(context).pop(context);
                          },
                          child: new Text("close"),)
                        ],
                      );
                    });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(children: <Widget>[
                    Expanded(child: new Text("Qty")),
                    Expanded(child: new Icon(Icons.arrow_drop_down)),
                  ]),
                ),
              ),
            ],
          ),

          // ======== the second buttons ===========
          Row(
            children: <Widget>[
              //<<<<<<<<<<<<<<< the size button >>>>>>>>>>>

              Expanded(
                child: MaterialButton(
                    onPressed: () {},
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 0.2,
                    child: new Text("Rent Now")),
              ),

              new IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  color: Colors.red,
                  onPressed: () {}),
              new IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Colors.red,
                  onPressed: () {}),
            ],
          ),
          Divider(),
          new ListTile(
            title: new Text("FEATURES"),
            subtitle: new Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "),
          ),
          Divider(),
          new ListTile(
            title: new Text("SPECIFICATION"),
          ),
          new Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
              child: new Text("FRAMESET",style: TextStyle(color: Colors.grey),),)
            ]
          ),

          new Row(
              children: <Widget>[
                Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text("FORK",style: TextStyle(color: Colors.grey),),),
                Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.prod_detail_frameset),
                ),
              ],
          ),

          new Row(
              children: <Widget>[
                Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text("CRANKS",style: TextStyle(color: Colors.grey),),)
              ]
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text("Similar Bikes"),
          ),
          //SIMILAR PRODUCTS SECTION
          Container(
            height: 360.0,
            child: Similar_products(),
          ),
        ],
      ),
    );
  }
}

class Similar_products extends StatefulWidget {
  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {
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

  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Similar_single_prod(
            prod_name: product_list[index]['name'],
            prod_picture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
            prod_frameset: product_list[index]['frameset'],
          );
        });
  }
}

class Similar_single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_price;
  final prod_old_price;
  final prod_frameset;

  Similar_single_prod(
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
          tag: prod_name,
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
                  ))),
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
                  )),
            ),
          )),
    );
  }
}

