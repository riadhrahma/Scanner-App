
import 'package:flutter/material.dart';

extension Floater on Widget {
  void showOnBottomSheet(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return this;
      },
    );
  }
}
