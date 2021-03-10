import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle_up/components/cart_products.dart';
import 'package:intl/intl.dart';
import 'package:cycle_up/components/horizontal_listview.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/pages/home.dart';
import 'package:flutter/services.dart';
import 'package:cycle_up/pages/cart.dart';
import 'package:cycle_up/components/databaseManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cycle_up/components/sendMail.dart';

import '../components/cart_products.dart';

class Carts_products extends StatefulWidget {
  @override
  _Carts_productsState createState() => _Carts_productsState();
}

class _Carts_productsState extends State<Carts_products> {
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
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return ProductDetails(
            prod_detail_name: userProductList[index]['name'],
            prod_detail_picture: userProductList[index]['picture'],
            prod_detail_new_price: userProductList[index]['price'],
            prod_detail_frameset: userProductList[index]['frameset'],
            prod_detail_fork: userProductList[index]['fork'],
            prod_detail_cranks: userProductList[index]['cranks'],
          );
        });
  }
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

class ProductDetails extends StatefulWidget {

  final prod_detail_name;
  final prod_detail_new_price;
  final prod_detail_cranks;
  final prod_detail_picture;
  final prod_detail_frameset;
  final prod_detail_features;
  final prod_detail_total;
  final prod_detail_date;
  final prod_type;
  final prod_detail_fork;
  final cart_id;

  ProductDetails({
    this.prod_detail_name,
    this.prod_detail_new_price,
    this.prod_detail_cranks,
    this.prod_detail_picture,
    this.prod_detail_frameset,
    this.prod_detail_features,
    this.prod_detail_total,
    this.prod_detail_date,
    this.prod_type,
    this.prod_detail_fork,
    this.cart_id
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}


class _ProductDetailsState extends State<ProductDetails> {
  final user = FirebaseAuth.instance.currentUser;
  bool _isButtonDisabled = false;
  String dropdownValueTwo = '';
  String dropdownValue = '';
  String textValue='';
  int numValue=0;

  bool disabledropdown = true;
  List<DropdownMenuItem<String>> menuitems = List();

  final Day = {
    "1": "1",
    "2": "2",
    "3": "3",
    "4": "4",
    "5": "5",
    "6": "6",
    "7": "7",
  };
  final Hour = {
    "1": "1",
    "2": "2",
    "3": "3",
    "4": "4",
    "5": "5",
    "6": "6",
    "7": "7",
    "8": "8",
    "9": "9",
    "10": "10",
    "11": "11",
  };
  void populateday(){
    for(String key in Day.keys){
      menuitems.add(DropdownMenuItem<String>(
        value: Day[key],
        child: Center(
          child: Text(
            Day[key],
          ),
        ),
      ));
    }
  }
  void populateHour(){
    for(String key in Hour.keys){
      menuitems.add(DropdownMenuItem<String>(
        value: Hour[key],
        child: Center(
          child: Text(
            Hour[key],
          ),
        ),
      ));
    }
  }

  void valuechanged(_value){
    if(_value == "Day"){
      typeValue = 500;
      populateday();
    }else if(_value =="Hour"){
      typeValue = 80;
      populateHour();
    }
    setState((){
      dropdownValue = _value;
      disabledropdown = false;
    });
  }

  void secondvaluechanged(_value){
    // numValue=int.parse(_value);
    getHrDay =  int.parse(_value);
    totalRentType = typeValue * int.parse(_value);
    setState((){
      dropdownValue = _value;
    });
  }

  void getFinalTotal(){
    finalTotal = totalRentType + (int.parse(dropdownValueTwo)*widget.prod_detail_new_price);
  }

  int getHrDay=0;
  int typeValue=0;
  int totalRentType=0;
  int finalTotal = 0;



  // DATE VARIABLE
  DateTime selectedDate = DateTime.now();
  final f = new DateFormat('yyyy-MM-dd');
  // HOURS VARIABLE
  final myController = TextEditingController();
  bool pressed = false;
  String countId = FirebaseFirestore.instance.collection("cartItems").doc().id;


  final navigatorKey = GlobalKey<NavigatorState>();

  void main() => runApp(
    MaterialApp(
      //home: HomePage(),
      navigatorKey: navigatorKey, // Setting a global key for navigator
    ),
  );

  //<<<<<< OVERRIDE FOR HOURS >>>>>>
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    Future createCartList(String _image, String bikeName, int price, String frameset, String fork, String cranks, String features, String countId) async {
      await databaseManager().pushToCart(_image, bikeName, price, frameset, fork, cranks, features, countId);
    }

    Future createRentalList(String bikeName, int price, DateTime selectedDate) async {
      await databaseManager().pushToRentals(bikeName, price, selectedDate, );
    }

    showMyDialog() {
      showDialog(
          context: (context),
          builder: (context) => Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                color: Colors.white,
                height: 500.0,
                width: 300,
                child: Column(
                  children: [
                    Text("Collateral Agreement", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Participant agrees to return the bike in clean, undamaged condition to avoid any additional charges for repair, maintenance or replacement. Participant accepts use of the equipment, AS IS, in reasonably good condition and accepts full responsibility for care of the equipment while under his/her possession. Damaged parts or components will be repaired/replaced at the shop’s discretion and Participant agrees to pay regular shop rates and retail prices for components replaced. Clean condition means normal wear and tear is accepted but does not include broken spokes, rims, bent rims, damaged frames, handlebars, seats or other parts from misuse and/or crashes. Note: All bikes should be returned clean of mud and debris. Any bike not returned clean may be assessed an additional cleaning fee at WRFI’s discretion. Participants credit card will be details will be collected at time of bike rental.'),
                    ),
                    Spacer(),
                    MaterialButton(
                        child: Text('Agree', style: TextStyle(color: Colors.white),),
                        color: Colors.red,
                        onPressed: (){
                          Navigator.of(context).pop(context);
                          showDialog(context: context, builder: (context) {
                            return new AlertDialog(
                              title: new Text("Rental Details"),
                              content: Column(
                                children: [
                                  Image.network(widget.prod_detail_picture, height: 200,),
                                  Divider(indent: 1.0,color: Colors.white),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      new Text("Bike Name:  ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.red)),
                                      new Text(widget.prod_detail_name,  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0)),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      new Text("Bike Price:  ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.red)),
                                      new Text(widget.prod_detail_new_price.toString(),  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0)),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      new Text("Date:  ", style: TextStyle(fontWeight: FontWeight.bold)),
                                      new Text(f.format(selectedDate)),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      new Text("$textValue:  ", style: TextStyle(fontWeight: FontWeight.bold)),
                                      new Text(getHrDay.toString()),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      new Text("Quantity: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                      new Text(dropdownValueTwo.toString()),
                                    ],
                                  ),
                                  Divider(indent: 1.0,color: Colors.white),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      new Text("Total: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                                      new Text('$finalTotal'),
                                    ],
                                  ),
                                ],
                              ),

                              actions: <Widget>[

                                new MaterialButton(

                                  onPressed: (){

                                    Navigator.of(context).pop(context);
                                    setState(() {
                                      pressed = true;
                                    });
                                    createRentalList(widget.prod_detail_name,finalTotal,selectedDate);
                                    SendMail();

                                  },
                                  child: new Text("              Rent Now              "),
                                  minWidth: 60,
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  elevation: 0.2,
                                ),

                                new MaterialButton(onPressed: (){
                                  Navigator.of(context).pop(context);
                                },
                                  child: new Text("close"),),
                                // pressed ? Text(" text is here ") : SizedBox(),
                              ],
                            );
                          });
                        })
                  ],
                ),
              ),
            ),
          )
      );
    }


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
          pressed ? Text(" Congratulation, Rental Successfull Pls check your email") : SizedBox(),
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.network(widget.prod_detail_picture, fit: BoxFit.cover,),
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
                            "\Php${widget.prod_detail_new_price}",
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

              //<<<<<<<<<<<<<<< the DATE button >>>>>>>>>>>>
              Expanded(
                child: MaterialButton(

                  onPressed: () => _selectDate(context),
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(children: <Widget>[
                    Expanded(child: new Text("Date")),
                    Expanded(child: new Icon(Icons.arrow_drop_down)),
                    // Expanded(child: new Text(selectedDate.toString())),
                  ]
                  ),

                ),

              ),

              //<<<<<<<<<<<<<<< the hour button >>>>>>>>>>>>
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                new Text("Rent Type"),
                                Divider(indent: 5.0,color: Colors.white),
                              ],
                            ),

                            content: Column(
                              children: [
                                new Text("1 hour = 80Php", style: TextStyle(height: 0, fontSize: 15),),
                                Divider(indent: 1.0,color: Colors.white),
                                new Text("1 Day = 500Php", style: TextStyle(height: 0, fontSize: 15),),
                                Divider(indent: 6.0,color: Colors.white),
                                Text("Choose type of rental and number of Day/Hr"),

                                Padding(padding: const EdgeInsets.all(16.0),

                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(5.0),

                                        child: DropdownButton<String>(
                                          items: [
                                            DropdownMenuItem<String>(
                                              value: "Day",
                                              child: Center(
                                                child: Text("Day"),
                                              ),
                                            ),
                                            DropdownMenuItem<String>(
                                              value: "Hour",
                                              child: Center(
                                                child: Text("Hour"),
                                              ),
                                            ),
                                          ],
                                          onChanged: (_value) => {valuechanged(_value),
                                            setState(() {
                                              dropdownValue = _value;
                                              textValue = _value;
                                            }),
                                          },
                                          hint: Text("Type: $textValue",
                                              style: TextStyle(color: Colors.grey)),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: DropdownButton<String>(

                                          items: menuitems,
                                          onChanged: disabledropdown ? null : (
                                              _value) => {secondvaluechanged(_value),//getNumValue(_value),
                                            setState(() {
                                              dropdownValue = _value;
                                              //int numValue = int.parse(_value);
                                            }),
                                          },
                                          hint: Text("Select a number",
                                              style: TextStyle(color: Colors.grey)),
                                          disabledHint: Text(
                                            "First select Day/Hr",
                                          ),
                                        ),

                                      ),
                                      //Text("$dropdownValue"),
                                    ],
                                  ),

                                ),
                              ],
                            ),
                            //),

                            actions: <Widget>[
                              new MaterialButton(onPressed: () {
                                Navigator.of(context).pop(context);
                              },
                                child: new Text("Ok"),)
                            ],
                          );

                        },
                      );
                    });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(children: <Widget>[
                    Expanded(child: new Text("Day/Hr")),
                    Expanded(child: new Icon(Icons.arrow_drop_down)),
                  ],),
                ),
              ),

              //<<<<<<<<<<<<<<< the QUANTITY button >>>>>>>>>>>>
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: DropdownButton<String>(
                        items: [
                          DropdownMenuItem<String>(
                            value: "1",
                            child: Center(
                              child: Text("1"),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "2",
                            child: Center(
                              child: Text("2"),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "3",
                            child: Center(
                              child: Text("3"),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "4",
                            child: Center(
                              child: Text("4"),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "5",
                            child: Center(
                              child: Text("5"),
                            ),
                          ),
                        ],

                        onChanged: (_value) => {
                          print(_value.toString()),
                          setState((){
                            dropdownValueTwo = _value;
                          }),
                        },

                        hint: Text("Qty: $dropdownValueTwo"),
                        // disabledHint: Text("Qtysdgfsdgf"),
                      ),
                    ),
                    // Text("$dropdownValue"),
                  ],
                ),

              ),

            ],
          ),

          // ======== the Rent now button ===========
          Row(
            children: <Widget>[
              //<<<<<<<<<<<<<<< the size button >>>>>>>>>>>
              Expanded(
                child: MaterialButton(
                    onPressed: () {

                      showMyDialog();
                      getFinalTotal();

                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 0.2,
                    child: new Text("Rent Now")),
              ),

              new IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  color: Colors.red,
                  onPressed:(){
                    // Single_cart_product().getCartId(countId);
                    //Single_cart_product(ctrId: countId.toString(),);
                    createCartList(widget.prod_detail_picture, widget.prod_detail_name, widget.prod_detail_new_price, widget.prod_detail_frameset,
                        widget.prod_detail_fork, widget.prod_detail_cranks, widget.prod_detail_features,countId);


                    // print(countId);
                  }

              ),
              Center(
                child: new IconButton(
                    icon: Icon(Icons.favorite_border),
                    color: Colors.red,
                    onPressed: () {
                      format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
                      var chosenDate = selectedDate;
                      var dDay = DateTime.now();
                      Duration difference = chosenDate.difference(dDay);
                      //assert(difference.inDays == 16592);
                      print(format(difference));
                    }),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text('Owner: '+user.displayName),
          ),

          Divider(),
          new ListTile(
            title: new Text("FEATURES"),
            subtitle: new Text(widget.prod_detail_features),
          ),
          Divider(),
          new ListTile(
            title: new Text("SPECIFICATION"),
          ),
          new Row(
              children: <Widget>[
                Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text("FRAMESET",style: TextStyle(color: Colors.grey),),),
                Padding(padding: EdgeInsets.all(5.0),
                  child: new Text(widget.prod_detail_frameset),
                ),
              ]
          ),

          new Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text("FORK",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.prod_detail_fork),
              ),
            ],
          ),

          new Row(
              children: <Widget>[
                Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text("CRANKS",style: TextStyle(color: Colors.grey),),),
                Padding(padding: EdgeInsets.all(5.0),
                  child: new Text(widget.prod_detail_cranks),
                )
              ]
          ),
          Divider(),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: new Text("Similar Bikes"),
          // ),
          //SIMILAR PRODUCTS SECTION
          Container(
            height: 70.0,
            child:Text(''),
            //Similar_products(),
          ),
        ],
      ),
    );
  }
//  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< DATE METHOD >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    // return selectedDate;
  }

}




class Similar_products extends StatefulWidget {
  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {
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
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Similar_single_prod(
            prod_name: userProductList[index]['name'],
            prod_picture: userProductList[index]['picture'],
            prod_fork: userProductList[index]['fork'],
            prod_price: userProductList[index]['price'],
            prod_frameset: userProductList[index]['frameset'],
            prod_cranks: userProductList[index]['cranks'],

          );
        });
  }
}

class Similar_single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_price;
  final prod_fork;
  final prod_frameset;
  final prod_cranks;
  // final prod_total;

  Similar_single_prod(
      {this.prod_name,
        this.prod_picture,
        this.prod_fork,
        this.prod_price,
        this.prod_frameset,
        this.prod_cranks,
        //  this.prod_total
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
                    prod_detail_fork: prod_fork,
                    prod_detail_picture: prod_picture,
                    prod_detail_frameset: prod_frameset,
                    prod_detail_cranks: prod_cranks,
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
                child: Image.network(prod_picture, fit: BoxFit.cover,),
              ),
            ),
          )),
    );
  }


}


