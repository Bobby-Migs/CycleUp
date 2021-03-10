import 'package:flutter/material.dart';

import 'package:cycle_up/provider/google_sign_in.dart';
import 'package:cycle_up/widget/sign_up_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cycle_up/pages/home.dart';
import 'package:cycle_up/Renter_Page/RentHome.dart';


//trial
import 'package:cycle_up/widget/logged_in_widget.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  String accountType;
  String adminEmail;
  Login({
    this.accountType,
    this.adminEmail
});
  String type = 'admin';


  @override
  Widget build(BuildContext context) => Scaffold(
    body: ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final provider = Provider.of<GoogleSignInProvider>(context);

          if (provider.isSigningIn) {
            return buildLoading();
          } else if(snapshot.hasData && accountType=='lister'){
            return HomePage();
          }else if(snapshot.hasData && accountType=='renter'){
            return RentHomePage();
          }
          // else if (accountType=='admin' && adminEmail=='rionjumiguel@gmail.com'){
          //   print(snapshot.data);
          //   return RentHomePage();
          // }
          else {
            return SignUpWidget();
          }
        },
      ),
    ),
  );

  Widget buildLoading() => Stack(
    fit: StackFit.expand,
    children: [
      Center(child: CircularProgressIndicator()),

    ],
  );
}




//==================================================================================
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