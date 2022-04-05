import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget>? buttons;
  final MainAxisAlignment? buttonsAligment;
  const CustomDialog({
    Key? key,
    required this.title,
    required this.content,
    this.buttons,
    this.buttonsAligment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(content),
      actions: buttons,
      actionsAlignment: buttonsAligment,
      title: Text(title),
    );
  }
}
