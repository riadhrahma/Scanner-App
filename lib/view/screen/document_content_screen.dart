import 'package:flutter/material.dart';
import 'package:labhouse/model/document_core.dart';

class DocumentScreenContent extends StatelessWidget {
  final DocumentCore documentCore;
  const DocumentScreenContent({Key? key, required this.documentCore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.scale(
        scale: 0.8,
        child: Stack(
          children: documentCore.documentComponents.blocks
              .map(
                (e) => Positioned(
                  // left: (e.cornerPoints.first.x.toDouble() / MediaQuery.of(context).devicePixelRatio)*00.2,
                  // top: (e.cornerPoints.last.y.toDouble() / MediaQuery.of(context).devicePixelRatio)*0.26,
                  left: (e.cornerPoints.first.x.toDouble() /
                          MediaQuery.of(context).devicePixelRatio) *
                      00.2,
                  top: (e.cornerPoints.last.y.toDouble() /
                      MediaQuery.of(context).devicePixelRatio),
                  child: Text(
                    e.text,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 9,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
