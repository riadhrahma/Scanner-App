part of 'document_controller_cubit.dart';

@immutable
abstract class DocumentControllerState {}

class DocumentControllerInitial extends DocumentControllerState {}

class DocumentControllerLoading extends DocumentControllerState {}

class UpdateTopFactor extends DocumentControllerState {
  final double updatedValue;

  UpdateTopFactor(this.updatedValue);
}

class UpdateLeftFactor extends DocumentControllerState {
  final double updatedValue;

  UpdateLeftFactor(this.updatedValue);
}

class UpdateScaleFactor extends DocumentControllerState {
  final double updatedValue;

  UpdateScaleFactor(this.updatedValue);
}

class UpdateTextFontSizeFactor extends DocumentControllerState {
  final double updatedValue;

  UpdateTextFontSizeFactor(this.updatedValue);
}

class SaveDocumentSuccess extends DocumentControllerState {}

class SaveDocumentFailed extends DocumentControllerState {}
