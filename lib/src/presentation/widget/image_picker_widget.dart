import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Card(
          elevation: 2.0,
          color: Colors.blueGrey,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(33.0),
              child: Icon(Icons.image_outlined),
            ),
          )
        ),
        Icon(FontAwesomeIcons.magnifyingGlass),
        Icon(Icons.camera_alt_outlined),
      ],
    );
  }
}