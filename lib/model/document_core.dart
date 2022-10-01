import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class DocumentCore {
  final XFile file;

  final RecognizedText documentComponents;

  DocumentCore({
    required this.file,
    required this.documentComponents,
  });
}
