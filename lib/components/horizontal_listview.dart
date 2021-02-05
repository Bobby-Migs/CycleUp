import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'images/category/cargo.png',
            image_caption: 'road bike',
          ),

          Category(
            image_location: 'images/category/bmx.png',
            image_caption: 'BMX',
          ),

          Category(
            image_location: 'images/category/folding.png',
            image_caption: 'Folding',
          ),

          Category(
            image_location: 'images/category/kids.png',
            image_caption: 'Kids',
          ),

          Category(
            image_location: 'images/category/mountain.png',
            image_caption: 'Mountain Bike',
          ),

          Category(
            image_location: 'images/category/tandem.png',
            image_caption: 'Tandem',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
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
