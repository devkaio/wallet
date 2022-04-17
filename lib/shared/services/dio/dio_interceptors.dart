import 'package:dio/dio.dart';
import 'package:wallet/shared/models/enviroment.dart';

class TokenInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path == '/token') {
      options.baseUrl = Enviroment.tokenUrlBase;
      options.path = Enviroment.tokenUrlBaseVersion + options.path;
    } else {
      options.baseUrl = Enviroment.urlBase;
      options.path = Enviroment.urlBaseVersion + options.path;
    }
    options.queryParameters = {'key': Enviroment.apiKey};
    super.onRequest(options, handler);
  }
}
