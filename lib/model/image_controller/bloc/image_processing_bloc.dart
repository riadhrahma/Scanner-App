import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labhouse/model/document_core.dart';
import 'package:labhouse/model/services/google_kit_services.dart';
import 'package:meta/meta.dart';

part 'image_processing_event.dart';
part 'image_processing_state.dart';

class ImageProcessingBloc extends Bloc<ImageProcessingEvent, ImageProcessingState> {
  ImageProcessingBloc() : super(ImageProcessingInitial()) {
    on<ImageProcessingEvent>((event, emit) async {
     if(event is ExtractTextFrmImage){
       GoogleKitService googleKitService =GoogleKitService();
       final result =await googleKitService.getText(event.file);
       emit(ExtractTextFrmImageState(documentCore: DocumentCore(file: event.file,documentComponents: result)));
     }
    });
  }
}
