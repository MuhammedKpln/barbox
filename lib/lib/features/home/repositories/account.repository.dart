import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:barbox/core/services/dio.service.dart';
import 'package:barbox/types/account.dart';
import 'package:barbox/types/domains.dart';
import 'package:barbox/types/login.dart';

abstract class BaseAccountRepository {
  Future<LoginResponse> login(String email, String password);
  Future<DomainsModel> fetchDomains();
  Future<AccountModel> createAccount(String domain, String password);
}

@LazySingleton()
class AccountRepository implements BaseAccountRepository {
  AccountRepository(this.dio);

  final DioService dio;

  @override
  Future<LoginResponse> login(String email, String password) async {
    final payload = {"address": email, "password": password};
    final response = await dio.post("/token", payload);

    switch (response?.statusCode) {
      case HttpStatus.ok:
        return LoginResponse.fromJson(response?.data);
      default:
        throw NetworkError(response!.statusCode.toString(), response.data);
    }
  }

  @override
  Future<DomainsModel> fetchDomains() async {
    final response = await dio.get("/domains");

    switch (response?.statusCode) {
      case HttpStatus.ok:
        return DomainsModel.fromJson(response?.data);
      default:
        throw NetworkError(response!.statusCode.toString(), response.data);
    }
  }

  @override
  Future<AccountModel> createAccount(String address, String password) async {
    final payload = {"address": address, "password": password};

    final response = await dio.post("/accounts", payload);
    print(response?.data);
    switch (response?.statusCode) {
      case HttpStatus.created:
        return AccountModel.fromJson(response?.data);
      default:
        throw NetworkError(response!.statusCode.toString(), response.data);
    }
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;

  NetworkError(this.statusCode, this.message);
}
