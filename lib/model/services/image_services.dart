import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?> pickImage({required ImageSource imageSource}) async {
    try {
      final image = await _imagePicker.pickImage(source: imageSource);

      return image;
    } catch (e) {
      throw Exception("something wrong");
    }
  }

  Future<String> saveImage(Uint8List pngBytes) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    String filePath = '$path/image${DateTime.now()}.png';

    final File newImage = File(filePath);
    await newImage.writeAsBytes(pngBytes);
    await newImage.create();
    return newImage.path;
  }
}
