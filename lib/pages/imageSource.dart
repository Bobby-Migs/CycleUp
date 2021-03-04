import 'package:cycle_up/pages/gallery_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/pages/CameraButtonWidget.dart';

class SourcePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Image'),
      ),
      body: ListView(
        children: <Widget>[
          CameraButtonWidget(),
          GalleryButtonWidget(),
        ],
      ),
    );
  }
}
