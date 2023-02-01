import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class DioService {
  late Dio _dio;
  BaseOptions get _baseOptions => BaseOptions(
        baseUrl: 'https://www.xx.com/api',
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );

  DioService() {
    _dio = Dio(_baseOptions);
  }

  Future<Response<dynamic>?> get(String path) async {
    final request = await _dio.get(path);

    if (request.statusCode == HttpStatus.ok) {
      return request;
    }

    throw Exception("Could not fetch: $path");
  }

  Future<Response<dynamic>?> delete(String path) async {
    final request = await _dio.delete(path);

    if (request.statusCode == HttpStatus.noContent) {
      return request;
    }

    throw Exception("Could not send DELETE request: $path");
  }
}
