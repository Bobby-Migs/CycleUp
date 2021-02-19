//import 'package:cycle_up/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './pages/login.dart';
//import 'package:cycle_up/widget/sign_up_widget.dart';

//Run|Debug
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Goolge SignIn';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.deepOrange),
    home: Login(),
  );
}


// //ORIGINAL
//
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: HomePage(),
//   ));
// }
//
