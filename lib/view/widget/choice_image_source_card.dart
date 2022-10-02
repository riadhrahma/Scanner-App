import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labhouse/model/image_controller/cubit/image_pick_cubit.dart';
import 'package:labhouse/utils/app_assets.dart';

class ChoiceImageSourceCard extends StatelessWidget {
  final ImageSource imageSource;
  const ChoiceImageSourceCard({Key? key, required this.imageSource})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget mainView;
    switch (imageSource) {
      case ImageSource.camera:
        mainView = InkWell(
          onTap: () {
            context.read<ImagePickCubit>().pickImage(imageSource: imageSource);
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppAssets.camera),
                  const Text('Camera',),
                ],
              ),
            ),
          ),
        );
        break;

      case ImageSource.gallery:
        mainView = InkWell(
          onTap: () {
            context.read<ImagePickCubit>().pickImage(imageSource: imageSource);
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppAssets.gallery),
                  const Text('Gallery'),
                ],
              ),
            ),
          ),
        );
        break;
    }
    return BlocBuilder<ImagePickCubit, ImagePickState>(
        builder: (context, object) {
      return mainView;
    });
  }
}
