import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:barbox/core/services/dio/interceptors/auth.interceptor.dart';

@LazySingleton()
class DioService {
  late Dio _dio;
  AuthInterceptor authInterceptor;
  BaseOptions get _baseOptions => BaseOptions(
        baseUrl: 'https://api.mail.tm',
        connectTimeout: 5000,
        receiveTimeout: 3000,
        contentType: "application/json",
        responseType: ResponseType.json,
      );

  DioService(this.authInterceptor) {
    _dio = Dio(_baseOptions);
    _dio.interceptors.add(authInterceptor);
  }

  Future<Response<dynamic>?> get(String path) async {
    final request = await _dio.get(path);

    if (request.statusCode == HttpStatus.ok) {
      return request;
    }

    throw Exception("Could not fetch: $path");
  }

  Future<Response<dynamic>?> post(
      String path, Map<String, dynamic> payload) async {
    final request = await _dio.post(path, data: payload);

    if (request.statusCode == HttpStatus.ok ||
        request.statusCode == HttpStatus.created) {
      return request;
    }

    throw Exception("Could not fetch: $path");
  }

  Future<Response<dynamic>?> delete(String path) async {
    try {
      final request = await _dio.delete(path);

      if (request.statusCode == HttpStatus.noContent) {
        return request;
      }
    } catch (e) {
      throw Exception("Could not send DELETE request: $path");
    }
    return null;
  }

  Future<Response<dynamic>?> patch(String path,
      {Map<String, dynamic>? data}) async {
    try {
      final request = await _dio.patch(path,
          options: Options(contentType: "application/ld+json"), data: data);

      if (request.statusCode == HttpStatus.ok) {
        return request;
      }
    } on DioError catch (e) {
      throw Exception("Could not send PATCH request: $path, $e");
    }
    return null;
  }

  Future<Response<dynamic>?> stream(
      {required String path,
      required CancelToken cancelToken,
      required String authToken,
      Map<String, dynamic>? queryParams}) async {
    final _dio = Dio();

    Response<ResponseBody> response = await _dio.get<ResponseBody>(
      path,
      options: Options(
        headers: {
          "Accept": "text/event-stream",
          "Cache-Control": "no-cache",
          "Authorization": "Bearer $authToken"
        },
        responseType: ResponseType.stream,
      ),
      queryParameters: queryParams,
      cancelToken: cancelToken,
    );

    return response;
  }
}
