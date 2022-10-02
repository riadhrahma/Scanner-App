import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:labhouse/model/cached_document.dart';
import 'package:labhouse/model/services/cached_images_services.dart';

class PreviousDocuments extends StatelessWidget {
  const PreviousDocuments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: FutureBuilder<List<CachedDocument>>(
          future: CachedImagesServices.getCachedDocuments(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CarouselSlider(
                  items: snapshot.data
                      ?.map((e) => Image.file(
                            File(e.path),
                            fit: BoxFit.cover,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ));
            } else {
              print(snapshot.error);
              return const SizedBox.shrink();
            }
          }),
    );
  }
}
