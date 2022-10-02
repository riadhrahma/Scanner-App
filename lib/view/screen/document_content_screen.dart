
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse/model/document_controller/cubit/document_controller_cubit.dart';
import 'package:labhouse/model/document_core.dart';
import 'package:labhouse/utils/floater.dart';
import 'package:labhouse/view/screen/loading_screen.dart';
import 'package:labhouse/view/widget/image_sliders.dart';
import 'package:labhouse/view/widget/info.dart';
import 'package:labhouse/view/widget/text_block_widget.dart';

class DocumentScreenContent extends StatefulWidget {
  final DocumentCore documentCore;

  const DocumentScreenContent({Key? key, required this.documentCore})
      : super(key: key);

  @override
  State<DocumentScreenContent> createState() => _DocumentScreenContentState();
}

class _DocumentScreenContentState extends State<DocumentScreenContent> {


  final GlobalKey _key = GlobalKey();

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
                    body: BlocListener<DocumentControllerCubit,
                        DocumentControllerState>(
                      listener: (context, state) {
                        if (state is DocumentControllerLoading) {
                          //of course it can be replaced by pushed named
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const LoadingScreen();
                          }));
                        }
                        if (state is SaveDocumentSuccess) {
                          Navigator.pop(context);
                          const InfoView(
                            message: "document Saved",
                            infoType: InfoType.success,
                          ).showOnBottomSheet(context);
                        }
                        if (state is SaveDocumentFailed) {
                          Navigator.pop(context);
                          const InfoView(
                            message: "no document Saved",
                            infoType: InfoType.failed,
                          ).showOnBottomSheet(context);
                        }
                      },
                      child: Transform.scale(
                          alignment: Alignment.topCenter,
                          scale: context
                              .read<DocumentControllerCubit>()
                              .scaleFactor,
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
                ),

                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                context
                                    .read<DocumentControllerCubit>()
                                    .takeScreenshot(key: _key);
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
                              onPressed: () => context
                                  .read<DocumentControllerCubit>()
                                  .showHideSliders(),
                              icon: Icon(context
                                      .read<DocumentControllerCubit>()
                                      .showDocumentSliders
                                  ? Icons.close
                                  : Icons.equalizer)),
                        ],
                      ),
                    ),
                  ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: ImageSliders(),
                ),
              ],
            ),
          );
        },
        buildWhen: (oldValue, newValue) => oldValue != newValue,
      ),
    );
  }
}
