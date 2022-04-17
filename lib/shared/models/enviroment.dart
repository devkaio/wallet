import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    } else {
      return '.env.development';
    }
  }

  static String urlBase = '${dotenv.env['URL_BASE']}';
  static String tokenUrlBase = '${dotenv.env['TOKEN_URL_BASE']}';
  static String apiKey = '${dotenv.env['API_KEY']}';
  static String urlBaseVersion = '${dotenv.env['URL_BASE_VERSION']}';
  static String tokenUrlBaseVersion = '${dotenv.env['TOKEN_URL_BASE_VERSION']}';
  static int appVersion = int.parse(dotenv.env['APP_VERSION'].toString());
}
