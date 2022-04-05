import 'package:flutter/foundation.dart';

class Enviroment {
  static String get getfileName {
    if (kReleaseMode) {
      return 'env.production';
    } else {
      return 'env.development';
    }
  }
}
