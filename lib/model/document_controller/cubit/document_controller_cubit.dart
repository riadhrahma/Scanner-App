import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:labhouse/model/cached_document.dart';
import 'package:labhouse/model/services/cached_images_services.dart';
import 'package:labhouse/model/services/image_services.dart';
import 'package:meta/meta.dart';

part 'document_controller_state.dart';

class DocumentControllerCubit extends Cubit<DocumentControllerState> {
  double topFactor = 0.8;
  double leftFactor = 0.0;
  double scaleFactor = 0.7;
  double fontSizeFactor = 0.2;
  bool showDocumentSliders = true;

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

  takeScreenshot({required GlobalKey key}) async {
    if (showDocumentSliders == true) {
      showDocumentSliders = false;
    }

    emit(DocumentControllerLoading());
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();





        final ImageService imageService = ImageService();
        final String filePath = await imageService.saveImage(pngBytes);
print(filePath);
        final CachedDocument cachedDocument =
            CachedDocument(filePath, DateTime.now());

        await CachedImagesServices.saveDocument(cachedDocument);

        emit(SaveDocumentSuccess());
      } else {
        emit(SaveDocumentFailed());
      }
    } catch (e) {
      print(e);
      emit(SaveDocumentFailed());
    }
  }

  void showHideSliders() {
    showDocumentSliders = !showDocumentSliders;
    //just to update the ui
    emit(DocumentControllerInitial());
  }
}
