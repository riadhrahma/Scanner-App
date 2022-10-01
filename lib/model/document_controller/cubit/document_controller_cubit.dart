import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'document_controller_state.dart';

class DocumentControllerCubit extends Cubit<DocumentControllerState> {
  double topFactor = 10;
  double leftFactor = 10;
  double scaleFactor = 1;
  double fontSizeFactor = 6;

  DocumentControllerCubit() : super(DocumentControllerInitial());

  void updateTopFactor(double value) {
    topFactor = value;
    emit(UpdateTopFactor(value));
  }

  void updateLeftFactor(double value) {
    leftFactor = value;
    emit(UpdateTopFactor(value));
  }

  void updateScaleFactor(double value) {
    scaleFactor = value;
    emit(UpdateScaleFactor(value));
  }

  void updateFontSizeFactor(double value) {
    fontSizeFactor = value;
    emit(UpdateTextFontSizeFactor(value));
  }
}
