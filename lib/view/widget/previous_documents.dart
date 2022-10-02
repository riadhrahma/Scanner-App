import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse/model/cached_document.dart';
import 'package:labhouse/model/image_controller/cubit/image_pick_cubit.dart';
import 'package:labhouse/model/services/cached_images_services.dart';
import 'package:labhouse/view/screen/document_viewer.dart';

class PreviousDocuments extends StatelessWidget {
  const PreviousDocuments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickCubit, ImagePickState>(
      builder: (context, state) {
        return Transform.translate(
          offset: const Offset(0, -18),
          child: SizedBox(
            height: 200,
            child: FutureBuilder<List<CachedDocument>>(
                future: CachedImagesServices.getCachedDocuments(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return CarouselSlider(
                      options: CarouselOptions(
                          height: 200,
                          aspectRatio: 0.5,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.vertical,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale),
                      items: snapshot.data!
                          .map((e) => InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return DocumentView(imagePath: e.path,);
                          }));
                        },
                            child: Image.file(
                                  File(e.path),
                                  width: 150,
                                ),
                          ))
                          .toList(),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
          ),
        );
      },
    );
  }
}
