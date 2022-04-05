import 'package:firebase_auth/firebase_auth.dart';

import 'shared/services/dio/custom_dio.dart';
import 'shared/services/http/http_services.dart';

class AppController {
  final HttpService dio = CustomDio();
  final FirebaseAuth firebase = FirebaseAuth.instance;
  bool sessionExpired = false;
}
