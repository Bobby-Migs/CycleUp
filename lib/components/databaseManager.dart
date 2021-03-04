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
  final CollectionReference rentalList =
  FirebaseFirestore.instance.collection('RentalList');


  // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< PUSHING DATA TO PRODUCT LIST >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> createUserData(
      String _image, String bikeName, int price, String frameset, String fork, String cranks, String features) async {
    return await productlist.doc()
        .set({'picture': _image, 'bikeName': bikeName, 'price': price, 'frameset': frameset, 'fork': fork, 'cranks': cranks, 'features':features})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

  }
// <<<<<<<<<<<<<<<<<<<<<<<< PUHING DATA TO CART >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> pushToCart(String _image, String bikeName, int price, String frameset, String fork, String cranks, String features, String ID) async {
    return await cartList.doc(ID)
        .set({'picture': _image, 'bikeName': bikeName, 'price': price, 'frameset': frameset, 'fork': fork, 'cranks': cranks, 'features':features, 'cartID': ID})
        .then((value) => print('item added to cart'))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // <<<<<<<<<<<<<<<<<<<<<<<< PUHING DATA TO RENTAL LIST >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> pushToRentals(String bikeName, int price, DateTime selectedDated) async {
    return await rentalList.doc()
        .set({'bikeName': bikeName, 'price': price, 'selectedDate': selectedDated,})
        .then((value) => print('item is rented'))
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
  // <<<<<<<<<<<<<<<<<<<<<< GET RENTAL INFO >>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future getRentalList() async {
    List itemList =[];

    try{
      await rentalList.get().then((QuerySnapshot querySnapshot) => {
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


  Future deleteUser(String ID)async {
    print(ID);
  String documentID;
    cartList
        .doc(ID.toString())
        .delete()
        .then((_) {
     print('item deleted from cart');
    });
  }
  
}