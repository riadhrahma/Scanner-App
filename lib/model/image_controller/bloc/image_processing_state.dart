part of 'image_processing_bloc.dart';

@immutable
abstract class ImageProcessingState {}

class ImageProcessingInitial extends ImageProcessingState {}

class ExtractTextFrmImageState extends ImageProcessingState {
  final DocumentCore documentCore;

  ExtractTextFrmImageState({required this.documentCore});
}
