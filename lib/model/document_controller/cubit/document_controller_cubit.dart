import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'document_controller_state.dart';

class DocumentControllerCubit extends Cubit<DocumentControllerState> {
  double topFactor = 0.8;
  double leftFactor = 0.0;
  double scaleFactor = 0.7;
  double fontSizeFactor = 0.2;

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
