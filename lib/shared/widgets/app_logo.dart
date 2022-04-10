import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../constants/constants.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Transform.rotate(
          angle: -math.pi / 2,
          child: const Icon(
            Icons.send_rounded,
            color: AppColors.white,
            size: 45.0,
          ),
        ),
      ),
    );
  }
}
