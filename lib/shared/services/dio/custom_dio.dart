import 'package:dio/dio.dart';

import '../../constants/api_routes.dart';
import '../http/http_services.dart';

class CustomDio implements HttpService {
  Dio get dio => _getDio();

  Dio _getDio() {
    var options = BaseOptions(
      baseUrl: ApiRoutes.baseUrl,
    );
    var dio = Dio(options);
    dio.interceptors.addAll([]);
    return dio;
  }

  @override
  Future<Response<T>> delete<T>(
      {required String url,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) {
    return dio.delete<T>(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response<T>> get<T>(
      {required String url,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) {
    return dio.get<T>(
      url,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @override
  Future<Response<T>> post<T>(
      {required String url,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) {
    return dio.post<T>(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response<T>> put<T>(
      {required String url,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) {
    return dio.put<T>(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }
}
