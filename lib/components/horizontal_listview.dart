import 'package:cycle_up/pages/mountainBike.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/pages/cart.dart';
import 'package:cycle_up/pages/roadBike.dart';
import 'package:cycle_up/pages/bmx.dart';
import 'package:cycle_up/pages/folding.dart';
import 'package:cycle_up/pages/kids.dart';
import 'package:cycle_up/pages/tandem.dart';


class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Road_Bike(
            image_location: 'images/category/cargo.png',
            image_caption: 'road bike',
          ),

          BMX(
            image_location: 'images/category/bmx.png',
            image_caption: 'BMX',
          ),

          Folding(
            image_location: 'images/category/folding.png',
            image_caption: 'Folding',
          ),

          Kids(
            image_location: 'images/category/kids.png',
            image_caption: 'Kids',
          ),

          MountainBike(
            image_location: 'images/category/mountain.png',
            image_caption: 'Mountain Bike',
          ),

          Tandem(
            image_location: 'images/category/tandem.png',
            image_caption: 'Tandem',
          ),
        ],
      ),
    );
  }
}

class Road_Bike extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Road_Bike({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> new RoadBike()));
        },
        child: Container(
          height: 200.0,
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption),
            ),
          ),
        ),
      ),
    );
  }
}

class BMX extends StatelessWidget {
  final String image_location;
  final String image_caption;

  BMX({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),

      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> new Bmx()));
        },
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption),
            ),
          ),
        ),
      ),
    );
  }
}

class Folding extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Folding({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> new FoldingBike()));
        },
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption),
            ),
          ),
        ),
      ),
    );
  }
}

class Kids extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Kids({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> new KidsBike()));
        },
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption),
            ),
          ),
        ),
      ),
    );
  }
}

class MountainBike extends StatelessWidget {
  final String image_location;
  final String image_caption;

  MountainBike({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> new Mountain_bike()));
        },
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption),
            ),
          ),
        ),
      ),
    );
  }
}

class Tandem extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Tandem({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> new TandemBike()));
        },
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption),
            ),
          ),
        ),
      ),
    );
  }
}

