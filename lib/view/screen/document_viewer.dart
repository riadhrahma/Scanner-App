import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DocumentView extends StatelessWidget {
  final String imagePath;
  const DocumentView({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: FileImage(File(imagePath)),
    );
  }
}
