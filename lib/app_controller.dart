import 'package:wallet/shared/models/auth_data.dart';

import 'shared/services/dio/custom_dio.dart';
import 'shared/services/http/http_services.dart';

class AppController {
  final HttpService dio = CustomDio();
  late AuthData authData;
}
