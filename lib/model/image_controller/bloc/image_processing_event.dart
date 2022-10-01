part of 'image_processing_bloc.dart';

@immutable
abstract class ImageProcessingEvent {}

class ExtractTextFrmImage extends ImageProcessingEvent {
  final XFile file;

  ExtractTextFrmImage({required this.file});
}
