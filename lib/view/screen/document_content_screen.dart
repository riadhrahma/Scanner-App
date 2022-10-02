import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:labhouse/model/document_controller/cubit/document_controller_cubit.dart';
import 'package:labhouse/model/document_core.dart';
import 'package:labhouse/view/widget/image_sliders.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:labhouse/view/widget/text_block_widget.dart';

class DocumentScreenContent extends StatefulWidget {
  final DocumentCore documentCore;
  const DocumentScreenContent({Key? key, required this.documentCore})
      : super(key: key);

  @override
  State<DocumentScreenContent> createState() => _DocumentScreenContentState();
}

class _DocumentScreenContentState extends State<DocumentScreenContent> {
  bool _showOptions = true;
  bool _showDocumentSliders = true;

  final GlobalKey _key = GlobalKey();

  void _takeScreenshot() async {
    RenderRepaintBoundary boundary =
        _key.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();

      // Saving the screenshot to the gallery
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(pngBytes),
          quality: 90,
          name: 'screenshot-${DateTime.now()}.png');

      if (kDebugMode) {
        print(result);
      }
    }
    setState(() {
      _showOptions = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DocumentControllerCubit>(
      create: (context) => DocumentControllerCubit(),
      child: BlocBuilder<DocumentControllerCubit, DocumentControllerState>(
        builder: (context, state) {
          return Material(
            child: Stack(
              children: [
                RepaintBoundary(
                  key: _key,
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    body: Transform.scale(
                        alignment: Alignment.topCenter,
                        scale:
                            context.read<DocumentControllerCubit>().scaleFactor,
                        child: Stack(
                          children:
                              widget.documentCore.documentComponents.blocks
                                  .map(
                                    (e) => TextBlockWidget(
                                      textBloc: e,
                                    ),
                                  )
                                  .toList(),
                        )),
                  ),
                ),
                if (_showOptions)
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                _takeScreenshot();
                              },
                              icon: const Icon(Icons.save)),
                          IconButton(
                              onPressed: () async {
                                await Clipboard.setData(ClipboardData(
                                    text: widget
                                        .documentCore.documentComponents.text));
                              },
                              icon: const Icon(Icons.copy)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _showDocumentSliders = !_showDocumentSliders;
                                });
                              },
                              icon: Icon(_showDocumentSliders
                                  ? Icons.close
                                  : Icons.equalizer)),
                        ],
                      ),
                    ),
                  ),
                if (_showDocumentSliders)
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: ImageSliders(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
