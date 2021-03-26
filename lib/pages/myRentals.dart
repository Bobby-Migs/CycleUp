import 'dart:io';
import 'package:cycle_up/components/databaseManager.dart';
import 'package:cycle_up/pages/imageSource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart' as validator ;
import 'package:cycle_up/pages/rentalOutput.dart';
import 'package:cycle_up/pages/result.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'imageModel.dart';
import 'package:cycle_up/pages/home.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
class Rentals extends StatefulWidget {

  @override
  _RentalsState createState() => _RentalsState();
}

class _RentalsState extends State<Rentals> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.2,
          backgroundColor: Colors.red,
          title: InkWell(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> new HomePage()));
                Navigator.of(context).pop(context);
                },
              child: Text('Cycle Up')),
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
                height:950.0,
               child: Card(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[
                     Container(
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
  String imgUrl= "";
  final user = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>();
  RentalOutput model = RentalOutput();

  final _storage = FirebaseStorage.instance;
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
      //var snapshot = await _storage.ref();
      print('No Path Received');
      return;
    } else {
      setState(() {
        fileMedia = result;
      });

      String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference= _storage.ref().child(imageFileName);
      UploadTask uploadTask = reference.putFile(fileMedia);
      TaskSnapshot taskSnapshot = await uploadTask;
      await taskSnapshot.ref.getDownloadURL().then((urlImg){
        imgUrl = urlImg;
      });

    }
  }

  final navigatorKey = GlobalKey<NavigatorState>();

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
                  Text("Terms and Conditions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('We recommend that you prepare your bike at the best condition and deliver it at our store at your specified day of lending your bike. Rest assured that your bike will be returned with no damage, hence the borrower will be accountable for the repair and will be charge with additional fees.'
                        'Please bring any two valid ID with you when you come to our office.'),
                  ),
                  Spacer(),
                  MaterialButton(
                      child: Text('Agree', style: TextStyle(color: Colors.white),),
                      color: Colors.red,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Rental(model: this.model,)));
                      })
                ],
              ),
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width /2.10;

    Future createProduct(String userName, String userEmail, String _image, String bikeName, int price, String frameset, String fork, String cranks, String features, String ID) async {
      await databaseManager().createUserData(userName, userEmail, _image, bikeName, price, frameset, fork, cranks, features, ID);
    }
    String listingID = FirebaseFirestore.instance.collection("productlistInfo").doc().id;

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
          MyTextFormField(
              hintText: 'Features (Optional)',
              validator: (String value){
                _formKey.currentState.save();
                if (value.isEmpty){
                  value = '';
                }
                return null;
              },
              onSaved: (String value){
                model.features = value;
              },
            ),
          Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
          Divider(),
          Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
          Text('Fill Up User Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
          MyTextFormField(
            hintText: 'Full Name',
            validator: (String value){
              if (value.isEmpty){
                return 'Enter Full Name';
              }
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value){
              model.ownerName = value;
            },
          ),
          MyTextFormField(
            hintText: 'Address',
            validator: (String value){
              if (value.isEmpty){
                return 'Enter Address';
              }
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value){
              model.address = value;
            },
          ),
          MyTextFormField(
            hintText: 'Contact Number',
            validator: (String value){
              if (value.isEmpty){
                return 'Enter Contact Number';
              }
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value){
              model.contNum = value;
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
               // Navigator.push(context, MaterialPageRoute(builder: (context) => Rental(model: this.model,)));
                createProduct(user.displayName.toString(), user.email.toString(), imgUrl, model.bikeName, model.price, model.frameset, model.fork, model.cranks, model.features, listingID);
                showMyDialog();
                //updateUser();
              }
            },
          ),
          new Container(

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





















