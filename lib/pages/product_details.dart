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
  final ownerEmail;
  final bikeColID;
  final comment;


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
    this.ownerEmail,
    this.bikeColID,
    this.comment,

  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}


class _ProductDetailsState extends State<ProductDetails> {

  List userProductList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await getMessage();
    if(resultant == null){
      print('Unable to retrieve');
    }else {
      setState(() {
        userProductList = resultant;
      });
    }
  }
  get index => null;




  final user = FirebaseAuth.instance.currentUser;

  // DATE VARIABLE
  DateTime selectedDate = DateTime.now();
  final f = new DateFormat('yyyy-MM-dd');
  // HOURS VARIABLE
  final myController = TextEditingController();
  bool pressed = false;
  String userMessage;

  String countId = FirebaseFirestore.instance.collection("cartItems").doc().id;

  Future createMessage(String messageID, String message, String userName) async {
    await databaseManager().pushTOComments(messageID, message, userName);
  }
  
  //<<<<<< OVERRIDE FOR HOURS >>>>>>
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  clearTextInput(){
    myController.clear();
  }

  @override
  Widget build(BuildContext context) {

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

          Container(
            height: 20.0,
            child:Text('Comments'),
            //Similar_products(),
          ),
          Container(
            height: 250,
            child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: userProductList.length,
                  itemBuilder: (context, index) {
                    return MessageViewer(
                      message: userProductList[index]['message'],
                      userName: userProductList[index]['userName'],
                    );
                  }
              ),
          ),
            Container(
              width: 280,
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: myController,
                      autocorrect: true,
                      decoration: InputDecoration(hintText: 'Leave a comment'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send_sharp),
                    onPressed: (){
                      userMessage=(DateTime.now().toString()+'\n    '+myController.text).toString();
                      createMessage(widget.bikeColID, userMessage, user.displayName);
                      fetchDatabaseList();
                      clearTextInput();
                    },
                  )
                ],
              )
          ),


        ],
      ),
    );

  }
  Future getMessage() async {
    List itemList =[];

    try{
      await FirebaseFirestore.instance.collection('comments')
          .where('messageID', isEqualTo: widget.bikeColID )
          .orderBy('message', )
          .get().then((QuerySnapshot querySnapshot) => {
        querySnapshot.docs.forEach((element) {
          itemList.add(element.data());
          print(element["message"]);
        }),
      });
      return itemList;
    }catch (e){
      print(e.toString());
      return null;
    }
  }

}



class MessageViewer extends StatefulWidget {
  final userName;
  final message;
  MessageViewer({
    this.userName,
    this.message
});

  @override
  _MessageViewerState createState() => _MessageViewerState();
}

class _MessageViewerState extends State<MessageViewer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: Colors.black12
        ),
        padding: EdgeInsets.fromLTRB(12, 8, 12, 12),
        constraints: BoxConstraints(maxWidth: 50),
        margin: EdgeInsets.fromLTRB(10, 0, 50, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.userName, style: TextStyle(color: Colors.blueGrey),),
            Text(widget.message),

          ],
        )
    );
  }
}

