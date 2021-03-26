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
            user_Name: userProductList[index]['userName'],
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
  final user_Name;

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
    this.cart_id,
    this.user_Name,
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




  //<<<<<< OVERRIDE FOR HOURS >>>>>>
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    // Future createCartList(String _image, String bikeName, int price, String frameset, String fork, String cranks, String features, String countId) async {
    //   await databaseManager().pushToCart(_image, bikeName, price, frameset, fork, cranks, features, countId);
    // }

    // Future createRentalList(String userName, String userEmail, String contNum, String address, String bikeName, int price, DateTime selectedDate) async {
    //   await databaseManager().pushToRentals(userName,userEmail,contNum, address, bikeName, price, selectedDate, );
    // }

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: InkWell(
            onTap: (){
               //Navigator.push(context, MaterialPageRoute(builder: (context)=> new HomePage()));
              Navigator.of(context).pop(context);
              },
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
             ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text('Owner: '+widget.user_Name),
          ),

          Divider(),
          new ListTile(
            title: new Text("FEATURES"),
            subtitle: new Text(widget.prod_detail_features),
          ),
          // Divider(),
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
            child:Text('Comments'),
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
