import 'package:flutter/material.dart';
import 'package:wallet/shared/constants/app_text_style.dart';

import '../constants/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const SecondaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          foregroundColor: MaterialStateProperty.all(AppColors.black),
          backgroundColor: MaterialStateProperty.all(AppColors.secondary),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))))),
      onPressed: onPressed,
      child: SizedBox(
        height: 50.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  text.toUpperCase(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: AppTextStyle.button,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
