import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse/model/document_controller/cubit/document_controller_cubit.dart';

class ImageSliders extends StatelessWidget {
  const ImageSliders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentControllerCubit, DocumentControllerState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const Text('scale factor'),
              Slider(
                  value: context.read<DocumentControllerCubit>().scaleFactor,
                  onChanged: context
                      .read<DocumentControllerCubit>()
                      .updateScaleFactor),
              const Text('left factor'),
              Slider(
                  value: context.read<DocumentControllerCubit>().leftFactor,
                  onChanged:
                      context.read<DocumentControllerCubit>().updateLeftFactor),
              const Text('top factor'),
              Slider(
                  value: context.read<DocumentControllerCubit>().topFactor,
                  onChanged:
                      context.read<DocumentControllerCubit>().updateTopFactor),
              const Text('text font size factor'),
              Slider(
                  value: context.read<DocumentControllerCubit>().fontSizeFactor,
                  onChanged: context
                      .read<DocumentControllerCubit>()
                      .updateFontSizeFactor)
            ],
          ),
        );
      },
    );
  }
}
