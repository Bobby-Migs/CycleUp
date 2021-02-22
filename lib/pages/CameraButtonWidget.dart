import 'dart:io';

import 'package:cycle_up/pages/imageModel.dart';
import 'package:flutter/material.dart';
import 'package:cycle_up/pages/list_tile_widget.dart';
import 'package:image_picker/image_picker.dart';

class CameraButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListTileWidget(
    text:'From Camera',
    icon: Icons.camera_alt,
  onClicked: () => pickCameraMedia(context),
  );
  Future pickCameraMedia(BuildContext context) async {
    final MediaSource source = ModalRoute.of(context).settings.arguments;

    final getMedia = source == MediaSource.image
        ? ImagePicker().getImage
        : ImagePicker().getVideo;

    final media = await getMedia(source: ImageSource.camera);
    final file = File(media.path);

    Navigator.of(context).pop(file);
  }
}
