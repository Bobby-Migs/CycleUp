import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:cycle_up/components/cart_products.dart';

class databaseManager {
  final CollectionReference productlist =
  FirebaseFirestore.instance.collection('productlistInfo');
  final CollectionReference cartList =
  FirebaseFirestore.instance.collection('cartItems');
  String cartId = FirebaseFirestore.instance.collection("cartItems").doc().id;
  String finalId;

  final cart_Id;
  databaseManager(
      {
        this.cart_Id
      });

  Future<void> createUserData(
      String _image, String bikeName, int price, String frameset, String fork, String cranks, String features) async {
    return await productlist.doc()
        .set({'picture': _image, 'bikeName': bikeName, 'price': price, 'frameset': frameset, 'fork': fork, 'cranks': cranks, 'features':features})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

  }

  Future<void> pushToCart(String _image, String bikeName, int price, String frameset, String fork, String cranks, String features, String ID) async {
    return await cartList.doc(ID)
        .set({'picture': _image, 'bikeName': bikeName, 'price': price, 'frameset': frameset, 'fork': fork, 'cranks': cranks, 'features':features})
        .then((value) => getId(ID.toString()))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //String ctrId=cartId.toString();
  
  Future getUsersList() async {
    List itemList =[];
    
    try{
      await productlist.get().then((QuerySnapshot querySnapshot) => {
        querySnapshot.docs.forEach((element) {
          itemList.add(element.data());
          print(element["bikeName"]);
        }),
      });
      return itemList;
    }catch (e){
      print(e.toString());
      return null;
    }
  }
//<<<<<<<<<<<<<<<<<<<< CART >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future getCartList() async {
    List itemList =[];

    try{
      await cartList.get().then((QuerySnapshot querySnapshot) => {
        querySnapshot.docs.forEach((element) {
          itemList.add(element.data());
          print(element["bikeName"]);
        }),
      });
      return itemList;
    }catch (e){
      print(e.toString());
      return null;
    }
  }
  Future getId(String id)async {
    String documentID = id;
    print(id);
    finalId = id;
    // Single_cart_product(ctrId: finalId,);

  }

  Future deleteUser(String ID)async {
    // var doc_ref = await Firestore.instance.collection("board").document(doc_id).collection("Dates").getDocuments();
    // doc_ref.documents.forEach((result) {
    //   print(result.documentID);
    // });
    print(ID);
  String documentID;
    cartList
        .doc(ID.toString())
        .delete()
        .then((_) {
     print(ID);
    });
  }
  
}