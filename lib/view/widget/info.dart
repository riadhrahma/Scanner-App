import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  final InfoType infoType;
  final String message;
  const InfoView({Key? key, required this.message, required this.infoType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        message,
      ),
      leading: Icon(
        Icons.info,
        color: infoType == InfoType.failed ? Colors.red : Colors.green,
      ),
    );
  }
}

enum InfoType { success, failed }
