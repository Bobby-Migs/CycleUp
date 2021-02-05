import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'home.dart';
//
//
//
// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   bool _isLoggedIn = false;
//
//   GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
//
//   _login() async{
//     try{
//       await _googleSignIn.signIn();
//       setState(() {
//         _isLoggedIn = true;
//       });
//     } catch (err){
//       print(err);
//     }
//   }
//
//   _logout(){
//     _googleSignIn.signOut();
//     setState(() {
//       _isLoggedIn = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//             child: _isLoggedIn
//                 ? Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Image.network(_googleSignIn.currentUser.photoUrl, height: 50.0, width: 50.0,),
//                 Text(_googleSignIn.currentUser.displayName),
//                 OutlineButton( child: Text("Logout"), onPressed: (){
//                   _logout();
//                 },)
//               ],
//             )
//                 : Center(
//               child: OutlineButton(
//                 child: Text("Login with Google"),
//                 onPressed: () {
//                   _login();
//                 },
//               ),
//             )),
//       ),
//     );
//   }
// }