
import 'dart:io';
import 'package:cycle_up/pages/imageSource.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/pages/product_details.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart' as validator ;
import 'package:cycle_up/pages/rentalOutput.dart';
import 'package:cycle_up/pages/result.dart';

import 'package:cycle_up/components/cart_products.dart';

import 'imageModel.dart';

class Rentals extends StatefulWidget {

  @override
  _RentalsState createState() => _RentalsState();
}

class _RentalsState extends State<Rentals> {
  // File fileMedia;
  // Future getImage(MediaSource source) async {
  //   final result = await Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => SourcePage(),
  //         settings: RouteSettings(
  //           arguments: source,
  //         ),
  //       ),
  //   );
  //   if (result == null){
  //     return;
  //   } else {
  //     setState(() {
  //       fileMedia = result;
  //     });
  //
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.2,
          backgroundColor: Colors.red,
          title: Text('My Rentals'),
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {}),

          ],
        ),

        body: new ListView(
            children: <Widget>[
              Container(
                height: 800.0,
               child: Card(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[
                     Container(
                       // child: Column(
                       //   children: [
                       //     fileMedia == null ? Icon(Icons.photo, size: 120) : Image.file(fileMedia, width: 100,height: 150,),
                       //     new MaterialButton(
                       //       onPressed: (){
                       //         getImage(MediaSource.image);
                       //       },
                       //       child: Text("Upload Image"),
                       //       color: Colors.red,
                       //       textColor: Colors.white,
                       //       elevation: 0.2,
                       //     )
                       //   ],
                       // ),
                     ),
                     Container(

                         child: new TestForm()),
                   ],
                 ),
               ),

              ),
            ]
        )



    );
  }
}


class TestForm extends StatefulWidget {
  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {

  File fileMedia;
  Future getImage(MediaSource source) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SourcePage(),
        settings: RouteSettings(
          arguments: source,
        ),
      ),
    );


    if (result == null){
      return;
    } else {
      setState(() {
        fileMedia = result;
      });

    }
  }

  final _formKey = GlobalKey<FormState>();
  RentalOutput model = RentalOutput();

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width /2.10;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            child: Column(

              children: [
                fileMedia == null ? Icon(Icons.photo, size: 120) : Image.file(fileMedia, width: 100,height: 150,),
                new MaterialButton(
                  onPressed: (){
                    getImage(MediaSource.image);
                  },
                  child: Text("Upload Image"),
                  color: Colors.red,
                  textColor: Colors.white,
                  elevation: 0.2,
                )
              ],

            ),
          ),
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                width: halfMediaWidth,
                child: MyTextFormField(
                  hintText: 'Bike Name',
                  validator: (String value){
                    if (value.isEmpty){
                      return 'Enter bike name';
                    }
                    return null;
                },
                  onSaved: (String value){
                    model.bikeName = value;
                    model.img = fileMedia;
                  },
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                width: halfMediaWidth,
                child: MyTextFormField(
                  hintText: 'Price',
                  validator: (String value){
                    if (value.isEmpty){
                      return 'Enter bike price';
                    }
                    return null;
                  },
                  onSaved: (String value){
                    model.price = int.parse(value);
                  },
                ),
              ),
            ],
          ),
          MyTextFormField(
            hintText: 'Frameset',
            validator: (String value){
              if (value.isEmpty){
                return 'Enter frameset';
              }
              return null;
            },
            onSaved: (String value){
              model.frameset = value;
            },
          ),
          MyTextFormField(
            hintText: 'Fork',
            validator: (String value){
              if (value.isEmpty){
                return 'Enter fork';
              }
              return null;
            },
            onSaved: (String value){
              model.fork = value;
            },
          ),
          MyTextFormField(
            hintText: 'Cranks',
            validator: (String value){
              if (value.isEmpty){
                return 'Enter cranks';
              }
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value){
              model.cranks = value;
            },
          ),
          RaisedButton(
            color: Colors.red,
            child: Text('Submit',
            style: TextStyle(
              color: Colors.white
            ),
            ),
            onPressed: (){
              if (_formKey.currentState.validate()){
                _formKey.currentState.save();

                Navigator.push(context, MaterialPageRoute(builder: (context) => Rental(model: this.model,)));
              }
            },
          )
        ],
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget{
final String hintText;
final Function validator;
final Function onSaved;
final bool isPassword;
final bool isEmail;

MyTextFormField({
  this.hintText,
  this.validator,
  this.onSaved,
  this.isPassword = false,
  this.isEmail = false,
});


  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      )
    );
  }
}





















