import 'dart:ui';
import 'package:cycle_up/components/cart_products.dart';
import 'package:intl/intl.dart';
import 'package:cycle_up/components/horizontal_listview.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/main.dart';
import 'package:cycle_up/pages/home.dart';
import 'package:flutter/services.dart';

class ProductDetails extends StatefulWidget {
  final prod_detail_name;
  final prod_detail_new_price;
  final prod_detail_old_price;
  final prod_detail_picture;
  final prod_detail_frameset;


  ProductDetails({
    this.prod_detail_name,
    this.prod_detail_new_price,
    this.prod_detail_old_price,
    this.prod_detail_picture,
    this.prod_detail_frameset
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}


class _ProductDetailsState extends State<ProductDetails> {

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
  // getNumValue(_value){
  //
  //   setState((){
  //     numValue = int.parse(_value);
  //   });
  //   return numValue;
  // }

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
    getHrDay = _value;
    totalRentType = typeValue * int.parse(_value);
    setState((){
      dropdownValue = _value;
    });
  }
  int getHrDay=0;
  int typeValue=0;
  int totalRentType=0;
  int finalTotal = 0;
  // DATE VARIABLE
  DateTime selectedDate = DateTime.now();
  final f = new DateFormat('yyyy-MM-dd hh:mm');
  // HOURS VARIABLE
  final myController = TextEditingController();
  // QUANTITY DROPDOWN


  //<<<<<< OVERRIDE FOR HOURS >>>>>>
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

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

                                    Text("$dropdownValue"),
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

          // ======== the second buttons ===========
          Row(
            children: <Widget>[
              //<<<<<<<<<<<<<<< the size button >>>>>>>>>>>

              Expanded(
                child: MaterialButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) {
                        return new AlertDialog(
                          title: new Text("Rental Details"),
                          content: Column(
                            children: [
                              Image.asset(widget.prod_detail_picture),
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
                              Divider(indent: 1.0,color: Colors.white),
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
                                  new Text(dropdownValue),
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
                                  new Text((widget.prod_detail_new_price + totalRentType + int.parse(dropdownValueTwo)).toString()),
                                ],
                              ),
                            ],
                          ),

                          actions: <Widget>[
                            new MaterialButton(onPressed: (){

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
                              child: new Text("close"),)
                          ],
                        );
                      });
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 0.2,
                    child: new Text("Rent Now")),
              ),

              new IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  color: Colors.red,
                  onPressed: () {
                  }),
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


