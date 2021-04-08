import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/widget/google_signup_button_widget.dart';
import 'package:cycle_up/widget/background_painter.dart';
import 'package:cycle_up/pages/login.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  String accountValue;
  String adminPass;
  final myController = TextEditingController();
  final navigatorKey = GlobalKey<NavigatorState>();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  void main() => runApp(
    MaterialApp(
      //home: HomePage(),
      navigatorKey: navigatorKey, // Setting a global key for navigator
    ),
  );
  showMyDialog() {
    showDialog(
        context: (context),
        builder: (context) => Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              color: Colors.white,
              height: 250.0,
              width: 300,
              child: Column(
                children: [
                  Spacer(),
                  Text("Enter Admin Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextField(
                      obscureText: true,
                      controller: myController,
                    ),
                  ),
                  Spacer(),
                  MaterialButton(
                      child: Text('Continue', style: TextStyle(color: Colors.white),),
                      color: Colors.red,
                      onPressed: (){
                        adminPass=myController.text.toString();
                        //print(myController.text.toString());
                        if(adminPass=='admin'){
                          Navigator.of(context).pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login(accountType: accountValue,adminPass: adminPass,)));

                        }else{
                          Navigator.of(context).pop(context);
                        }
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => Rental(model: this.model,)));
                      })
                ],
              ),
            ),
          ),
        )
    );
  }

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> SHOW DIALOG FOR ADMIN >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      //CustomPaint(painter: BackgroundPainter()),
      buildSignUp(),
      new Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bannerImg3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.only(top: 50.0),
          child: buildSignUp())
    ],
  );

  Widget buildSignUp() => Column(
    children: <Widget>[
      // Spacer(),
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          width: 200,
        ),
      ),

      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Container(
          margin: EdgeInsets.all(30),
          width:  MediaQuery.of(context).size.width,
          height:  MediaQuery.of(context).size.height/1.25,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white70,
              width: 5,
            ),
            color: Colors.black.withOpacity(0.25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children:[
              Spacer(),
               Text(
                'Welcome To Cycle Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                 textAlign: TextAlign.center,
              ),
        Spacer(flex: 1,),
        Container(
           padding: EdgeInsets.all(5.0),
           width: 200.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            items: [
              DropdownMenuItem<String>(
                value: "renter",
                child: Center(
                  child: Text("Rent a bike"),
                ),
              ),
              DropdownMenuItem<String>(
                value: "lister",
                child: Center(
                  child: Text("List a bike"),
                ),
              ),
              DropdownMenuItem<String>(
                value: "admin",
                child: Center(
                  child: Text("admin"),
                ),
              ),
            ],

            onChanged: (_value) => {
              print(_value.toString()),
              setState((){
                accountValue = _value;
                if(accountValue=='admin'){
                  showMyDialog();
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Login(adminPass: 'admin',)));
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login(accountType: accountValue)));
                }

              }),
            },

            hint:Container(
              width: 150,
              child: Text(
                "Select Account Type",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.end,
              ),
            ),
            value: accountValue,

            //Text("Select"),
            // disabledHint: Text("Qtysdgfsdgf"),
          ),
        ),
              Spacer(flex: 1,),

     Row(
       children: [
         Text(" ____________________", style: TextStyle(color: Colors.white),
           textAlign: TextAlign.center,),
         Text(" and", style: TextStyle(color: Colors.white),
    textAlign: TextAlign.center,),
         Text(" ____________________", style: TextStyle(color: Colors.white),
           textAlign: TextAlign.center,),
       ],
     ),

        Spacer(),

        InkWell(
            onTap: (){

              //GoogleSignupButtonWidget();
            },
            child: GoogleSignupButtonWidget()
        ),
        SizedBox(height: 12),
              Spacer(flex: 1,),

  ],
          ),
  ),
      ),
    ],
  );
}
