import 'package:flutter/material.dart';
import 'package:cycle_up/About/googleMaps.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('About'),

      ),
      body: ListView(
        children: [
          Container(
          height: 650,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Cycle Up',textAlign: TextAlign.start, style: TextStyle( fontWeight: FontWeight.bold, fontSize: 28, ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('CycleUp are made for bike lovers and new access for bike owners to lend their own bike for some short income. '
                    'The app is made in order to reduce traffic and to promote more bike brands and encourage more people to use bikes as a transportation.'),
              ),
              Divider(),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Contact Us', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 25, color: Colors.blueAccent ),),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.phone_android),
                    title: Text('09270520213'),
                    subtitle: Text('Globe'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.phone_android),
                    title: Text('09120520213'),
                    subtitle: Text('Smart'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('(074) 222 0158'),
                    subtitle: Text('Phone'),
                  ),

                ],
              ),
              Divider(),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Locate Us', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 25, color: Colors.blueAccent ),),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Kisad Road, Baguio Benguet'),
                subtitle: Text('Near Heritage Buffet'),
              ),
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutMaps()));
                  },
                  child: Text('Go to Map'))
            ],
          ),
        ),
        ],
      ),
    );
  }
}
