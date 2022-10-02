import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labhouse/model/image_controller/bloc/image_processing_bloc.dart';
import 'package:labhouse/model/image_controller/cubit/image_pick_cubit.dart';
import 'package:labhouse/utils/app_assets.dart';
import 'package:labhouse/utils/floater.dart';
import 'package:labhouse/view/screen/document_content_screen.dart';
import 'package:labhouse/view/screen/loading_screen.dart';
import 'package:labhouse/view/widget/choice_image_source_card.dart';
import 'package:labhouse/view/widget/info.dart';
import 'package:labhouse/view/widget/previous_documents.dart';

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({Key? key}) : super(key: key);

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Stack(
      children: [
        Image.asset(
          AppAssets.background,
          height: size.height,
          width: size.width,
          fit: BoxFit.cover,
        ),
        Container(
          height: size.height,
          width: size.width,
          color: Colors.black54,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
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
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
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
                      }
                      if (state is ImagePickSuccess) {
                        BlocProvider.of<ImageProcessingBloc>(context)
                            .add(ExtractTextFrmImage(file: state.file));
                      }
                      if (state is ImagePickFailed) {
                        Navigator.pop(context);
                        const InfoView(
                          message: "something wrong or image no selected",
                          infoType: InfoType.failed,
                        ).showOnBottomSheet(context);
                      }
                    },
                  )
                ],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Document Scanner',
                            textStyle: const TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                        totalRepeatCount: 1,
                        pause: const Duration(milliseconds: 100),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: false,
                      ),
                    ),
                    BlocBuilder<ImagePickCubit, ImagePickState>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            //just to refresh the future builder that fetch document from cache
                            context.read<ImagePickCubit>().refreshUi();
                          },
                          child: Image.asset(
                            AppAssets.printer,
                            width: 150,
                          ),
                        );
                      },
                    ),
                    const PreviousDocuments(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        ChoiceImageSourceCard(imageSource: ImageSource.camera),
                        ChoiceImageSourceCard(imageSource: ImageSource.gallery),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
