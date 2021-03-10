import 'package:flutter/material.dart';

class adminLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Enter your username'
        ),
      ),
    );
  }
}
