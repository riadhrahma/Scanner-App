import 'package:bloc/bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:labhouse/model/services/image_services.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'image_pick_state.dart';

class ImagePickCubit extends Cubit<ImagePickState> {
  XFile? file;
  ImagePickCubit() : super(ImagePickInitial());

  Future<void> pickImage({required ImageSource imageSource}) async {
    emit(ImagePickLoading());
    ImageService imageService = ImageService();
    final result = await imageService.pickImage(imageSource: imageSource);

    if (result != null) {
      emit(ImagePickSuccess(file: result));
    } else {
      emit(ImagePickFailed());
    }
  }

  void refreshUi(){
    emit(ImagePickInitial());
  }
}
