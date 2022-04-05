import 'package:flutter/material.dart';
import 'package:wallet/shared/constants/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          foregroundColor: MaterialStateProperty.all(
            AppColors.primary,
          )),
    );
  }
}
