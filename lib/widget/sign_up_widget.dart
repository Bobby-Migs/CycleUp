import 'package:flutter/material.dart';
import 'package:cycle_up/widget/google_signup_button_widget.dart';
import 'package:cycle_up/widget/background_painter.dart';

class SignUpWidget extends StatelessWidget {
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
    children: [

      Spacer(),
      Align(
        alignment: Alignment.centerLeft,

        child: Container(

          margin: EdgeInsets.symmetric(horizontal: 30),
          width: 200,
          child: Text(
            'Welcome To Cycle Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      Spacer(),
      GoogleSignupButtonWidget(),
      SizedBox(height: 12),
      Text(
        'Login to continue',
        style: TextStyle(fontSize: 16, color: Colors.white,),
      ),
      Spacer(),
    ],
  );
}
