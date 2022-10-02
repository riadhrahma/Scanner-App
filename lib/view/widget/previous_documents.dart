import 'package:flutter/material.dart';

class PreviousDocuments extends StatelessWidget {
  const PreviousDocuments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView(),
    );
  }
}
