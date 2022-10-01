import 'package:flutter/material.dart';

class DocumentText extends StatelessWidget {
  final String text;
  final TextType textType;
  const DocumentText({
    Key? key,
    required this.text,
    required this.textType,
  }) : super(key: key);

  TextStyle? textStyle(
      {required TextType textType, required BuildContext context}) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    switch (textType) {
      case TextType.title:
        return textTheme.headline6;

      case TextType.body:
        return textTheme.bodyText1;

      //we can develop more the style by adding the subtitle text style...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle(
        textType: textType,
        context: context,
      ),
    );
  }
}

enum TextType { title, body }
