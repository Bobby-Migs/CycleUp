import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle_up/Admin/runningRentals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:cycle_up/components/cart_products.dart';
import 'package:firebase_auth/firebase_auth.dart';

class databaseManager {
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference productlist =
  FirebaseFirestore.instance.collection('productlistInfo');
  final CollectionReference cartList =
  FirebaseFirestore.instance.collection('cartItems');
  final CollectionReference rentalList =
  FirebaseFirestore.instance.collection('RentalList');
  final CollectionReference bikeCollections =
  FirebaseFirestore.instance.collection('bikeCollections');
  final CollectionReference rentalRequests =
  FirebaseFirestore.instance.collection('RentalRequests');
  final CollectionReference userNotif =
  FirebaseFirestore.instance.collection('userNotif');
  final CollectionReference displayedBikes =
  FirebaseFirestore.instance.collection('displayedBikes');
  final CollectionReference runningRentals =
  FirebaseFirestore.instance.collection('runningRentals');
  String getOwnerName;



  // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< PUSHING DATA TO PRODUCT LIST >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> createUserData(
      String userName, String userEmail, String _image, String bikeName, int price, String frameset, String fork, String cranks, String features, String ID) async {
    return await productlist.doc(ID)
        .set({'userName': userName, 'userEmail':userEmail, 'picture': _image, 'bikeName': bikeName, 'price': price, 'frameset': frameset, 'fork': fork, 'cranks': cranks, 'features':features, 'listingID': ID})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add product: $error"));
  }
// <<<<<<<<<<<<<<<<<<<<<<<< PUHING DATA TO CART >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> pushToCart(String ownerName, String borrowerEmail, String ownerEmail, String _image, String bikeName, int price, String frameset, String fork, String cranks, String features, String ID) async {
    return await cartList.doc(ID)
        .set({'ownerName': ownerName, 'borrowerEmail':borrowerEmail,'ownerEmail':ownerEmail, 'picture': _image, 'bikeName': bikeName, 'price': price, 'frameset': frameset, 'fork': fork, 'cranks': cranks, 'features':features, 'cartID': ID})
        .then((value) => print('item added to cart'))
        .catchError((error) => print("Failed to add to cart: $error"));
  }

  // <<<<<<<<<<<<<<<<<<<<<<<< PUHING DATA TO RENTAL LIST >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> pushToRentals(String _image, String ownerName, String userName, String userEmail, String contNum, String address, String bikeName, int price, DateTime selectedDated, int days, String type,String ID) async {
    return await rentalList.doc(ID)
        .set({'picture': _image, 'ownerName':ownerName, 'borrowerName': userName, 'userEmail':userEmail,'contactNum': contNum, 'address': address, 'bikeName': bikeName, 'price': price, 'selectedDate': selectedDated, 'days': days, 'type': type, 'borrowerDocID':ID})
        .then((value) => print('item is rented'))
        .catchError((error) => print("Failed to add to rentals: $error"));
  }
  // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< PUSHING DATA TO BikeCollections LIST >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> pushBikeCollections(
      String userName, String userEmail, String _image, String bikeName, int price, String frameset, String fork, String cranks, String features) async {
    return await bikeCollections.doc()
        .set({'userName': userName, 'userEmail':userEmail, 'picture': _image, 'bikeName': bikeName, 'price': price, 'frameset': frameset, 'fork': fork, 'cranks': cranks, 'features':features})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add product: $error"));
  }
  // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< PUSHING DATA TO RENTALREQUEST LIST >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> pushToRentalRequest(String _image, String ownerName, String userName, String userEmail, String contNum, String address, String bikeName, int price, DateTime selectedDated) async {
    return await rentalRequests.doc()
        .set({'picture': _image, 'ownerName':ownerName, 'borrowerName': userName, 'userEmail':userEmail,'contactNum': contNum, 'address': address, 'bikeName': bikeName, 'price': price, 'selectedDate': selectedDated,})
        .then((value) => print('item is rented'))
        .catchError((error) => print("Failed to add to rentals: $error"));
  }
  // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< USER NOTIFICATION >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> pushToNotification(String ownerName, String borrowerName, String bikeName, String message, DateTime selectedDated,DateTime rentalDueDate) async {
    return await userNotif.doc()
        .set({'ownerName': ownerName, 'borrowerName': borrowerName, 'bikeName':bikeName,'message': message, 'dateRented': selectedDated, 'rentalDueDate':rentalDueDate})
        .then((value) => print('item is rented'))
        .catchError((error) => print("Failed to send notification message: $error"));
  }

  // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< PUSHING DATA TO PRODUCT LIST >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> pustToDisplay(
      String userName, String userEmail, String _image, String bikeName, int price, String frameset, String fork, String cranks, String features, String ID) async {
    return await displayedBikes.doc(ID)
        .set({'userName': userName, 'userEmail':userEmail, 'picture': _image, 'bikeName': bikeName, 'price': price, 'frameset': frameset, 'fork': fork, 'cranks': cranks, 'features':features, 'displayID': ID})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add product: $error"));
  }
  // <<<<<<<<<<<<<<<<<<<<<<<< PUHING DATA TO DISPLAY RENTAL LIST >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<void> pushToRunningRentals(String _image, String ownerName, String userName, String userEmail, String contNum, String address, String bikeName, int price, DateTime selectedDated, int days, String type,String ID) async {
    return await runningRentals.doc(ID)
        .set({'picture': _image, 'ownerName':ownerName, 'borrowerName': userName, 'userEmail':userEmail,'contactNum': contNum, 'address': address, 'bikeName': bikeName, 'price': price, 'selectedDate': selectedDated, 'days': days, 'type': type, 'borrowerDocID':ID})
        .then((value) => print('item is rented'))
        .catchError((error) => print("Failed to add to rentals: $error"));
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
  Future getDisplayedBikes() async {
    List itemList =[];

    try{
      await displayedBikes.get().then((QuerySnapshot querySnapshot) => {
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

  //>>>>>>>>>>>>>>>>>>>>>>>>> BIKE COLLECTIONS >>>>>>>>>>>>>>>>>>>>>>>
  Future getBikeCollections() async {
    List itemList =[];

    try{
      await bikeCollections.get().then((QuerySnapshot querySnapshot) => {
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
      await cartList.where('borrowerEmail', isEqualTo: user.email).get().then((QuerySnapshot querySnapshot) => {
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
  // <<<<<<<<<<<<<<<<<<<<<< GET RENTAL INFO >>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future getDisplayedRentalList() async {

    List itemList =[];

    try{
      await runningRentals.get().then((QuerySnapshot querySnapshot) => {
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
  // <<<<<<<<<<<<<<<<<<<<<< GET RENTALREQUEST >>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future getAllowedRentalReq() async {

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
  // >>>>>>>>>>>>>>>>>>>>>> GET NOTIFICATION >>>>>>>>>>>>>>>>>>>>>>>>>
  Future getNotification() async {
    List itemList =[];

    try{
      await userNotif.where('ownerName', isEqualTo: user.displayName).get().then((QuerySnapshot querySnapshot) => {
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

  Future getNotifications() async {
    List itemList =[];

    try{
      await rentalRequests.where('ownerName', isEqualTo: user.displayName).get().then((QuerySnapshot querySnapshot) => {
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

  Future deleteListingReq(String ID)async {
    print(ID);
    String documentID;
    productlist
        .doc(ID.toString())
        .delete()
        .then((_) {
      print('item deleted from Listing Request');
    });
  }

Future deleteBorrowReq(String ID)async {
  print(ID);
  String documentID;
  rentalList
      .doc(ID.toString())
      .delete()
      .then((_) {
    print('item deleted from Rental Lists Request');
  });
}
}