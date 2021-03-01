import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';


class databaseManager {
  final CollectionReference productlist =
  FirebaseFirestore.instance.collection('productlistInfo');
  final CollectionReference cartList =
  FirebaseFirestore.instance.collection('cartItems');

  Future<void> createUserData(
      String _image, String bikeName, int price, String frameset, String fork, String cranks) async {
    return await productlist.doc()
        .set({'picture': _image, 'bikeName': bikeName, 'price': price, 'frameset': frameset, 'fork': fork, 'cranks': cranks})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> pushToCart(
      String _image, String bikeName, int price, String frameset, String fork, String cranks) async {
    return await cartList.doc()
        .set({'picture': _image, 'bikeName': bikeName, 'price': price, 'frameset': frameset, 'fork': fork, 'cranks': cranks})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  
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
  
}