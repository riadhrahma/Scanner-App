part of 'image_pick_cubit.dart';

@immutable
abstract class ImagePickState {}


class ImagePickInitial extends ImagePickState {}

class ImagePickLoading extends ImagePickState{

}

class ImagePickSuccess extends ImagePickState{
  final XFile file;
  ImagePickSuccess({required this.file});
}


class ImagePickFailed extends ImagePickState{}
