// ignore: depend_on_referenced_packages
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class GoogleKitService {
  Future<RecognizedText> getText(XFile file) async {
    InputImage inputImage = InputImage.fromFilePath(file.path);
    final TextRecognizer textRecognizer = TextRecognizer();
    final RecognizedText result = await textRecognizer.processImage(inputImage);

    return result;
  }
}
