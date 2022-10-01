import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse/model/document_controller/cubit/document_controller_cubit.dart';
import 'package:labhouse/model/document_core.dart';
import 'package:labhouse/view/widget/image_sliders.dart';

class DocumentScreenContent extends StatefulWidget {
  final DocumentCore documentCore;
  const DocumentScreenContent({Key? key, required this.documentCore})
      : super(key: key);

  @override
  State<DocumentScreenContent> createState() => _DocumentScreenContentState();
}

class _DocumentScreenContentState extends State<DocumentScreenContent> {
  bool _showOptions = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DocumentControllerCubit>(
      create: (context) => DocumentControllerCubit(),
      child: BlocBuilder<DocumentControllerCubit, DocumentControllerState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Transform.scale(
                    alignment: Alignment.topCenter,
                    scale: context.read<DocumentControllerCubit>().scaleFactor,
                    child: Stack(
                      children: widget.documentCore.documentComponents.blocks
                          .map(
                            (e) => Positioned(
                              // left: (e.cornerPoints.first.x.toDouble() / MediaQuery.of(context).devicePixelRatio)*00.2,
                              // top: (e.cornerPoints.last.y.toDouble() / MediaQuery.of(context).devicePixelRatio)*0.26,
                              left: e.cornerPoints.first.x.toDouble() *
                                  context
                                      .read<DocumentControllerCubit>()
                                      .leftFactor,
                              top: e.cornerPoints.last.y.toDouble() *
                                  context
                                      .read<DocumentControllerCubit>()
                                      .topFactor,
                              child: SelectableText(
                                e.text,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: context
                                          .read<DocumentControllerCubit>()
                                          .fontSizeFactor *
                                      100,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )),
                 Align(
                  alignment: Alignment.topRight,
                  child: IconButton(onPressed: (){
                   setState(() {
                     _showOptions=! _showOptions;
                   });
                  }, icon: const Icon(Icons.add)),
                ),
                if(_showOptions)
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
