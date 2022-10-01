import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labhouse/model/image_controller/bloc/image_processing_bloc.dart';
import 'package:labhouse/model/image_controller/cubit/image_pick_cubit.dart';
import 'package:labhouse/view/screen/document_content_screen.dart';
import 'package:labhouse/view/screen/loading_screen.dart';
import 'package:labhouse/view/widget/choice_image_source_card.dart';

class PickImageScreen extends StatelessWidget {
  const PickImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ImageProcessingBloc>(
              create: (BuildContext context) => ImageProcessingBloc(),
            ),
            BlocProvider<ImagePickCubit>(
              create: (BuildContext context) => ImagePickCubit(),
            ),
          ],
          child: MultiBlocListener(
            listeners: [
              BlocListener<ImageProcessingBloc, ImageProcessingState>(
                  listener: (context, state) {
                if (state is ExtractTextFrmImageState) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return DocumentScreenContent(
                      documentCore: state.documentCore,
                    );
                  }));
                }
              }),
              BlocListener<ImagePickCubit, ImagePickState>(
                listener: (context, state) {
                  if (state is ImagePickLoading) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const LoadingScreen();
                    }));
                  } else {
                    Navigator.pop(context);
                  }
                  if (state is ImagePickSuccess) {
                    BlocProvider.of<ImageProcessingBloc>(context)
                        .add(ExtractTextFrmImage(file: state.file));
                  }
                  if (state is ImagePickFailed) {
                    //todo show error popup
                  }
                },
              )
            ],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                ChoiceImageSourceCard(imageSource: ImageSource.camera),
                ChoiceImageSourceCard(imageSource: ImageSource.gallery),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
