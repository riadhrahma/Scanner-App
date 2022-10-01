import 'package:image_picker/image_picker.dart';

class ImageService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?> pickImage({required ImageSource imageSource}) async {
    try {
      final image = await _imagePicker.pickImage(source: imageSource);

      return image;
    } catch (e) {
      throw Exception("something wrong");
    }
    // }
  }
}
