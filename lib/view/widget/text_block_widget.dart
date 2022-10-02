import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:labhouse/model/document_controller/cubit/document_controller_cubit.dart';

class TextBlockWidget extends StatelessWidget {
  final TextBlock textBloc;

  const TextBlockWidget({Key? key, required this.textBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentControllerCubit, DocumentControllerState>(
      builder: (context, state) {
        return Positioned(
          left: textBloc.cornerPoints.first.x.toDouble() *
              context
                  .read<DocumentControllerCubit>()
                  .leftFactor,
          top: textBloc.cornerPoints.last.y.toDouble() *
              context
                  .read<DocumentControllerCubit>()
                  .topFactor,
          child: SelectableText(
            textBloc.text,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: context
                  .read<DocumentControllerCubit>()
                  .fontSizeFactor *
                  100,
            ),
          ),
        );
      },
    );
  }
}
