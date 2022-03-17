import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:spamify/types/account.dart';
import 'package:spamify/types/domains.dart';

import '../../types/login.dart';
import '../../utils.dart';

abstract class AccountRepository {
  Future<LoginResponse> login(String email, String password);
  Future<DomainsModel> fetchDomains();
  Future<AccountModel> createAccount(String domain, String password);
}

class AccountRepo implements AccountRepository {
  @override
  Future<LoginResponse> login(String email, String password) async {
    final payload = json.encode({"address": email, "password": password});
    final url = Uri.parse("https://api.mail.tm/token");
    final response = await http.post(url, body: payload, headers: {
      "Content-Type": "application/json",
    });

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = json.decode(response.body);

        return LoginResponse.fromJson(jsonBody);
      default:
        throw NetworkError(response.statusCode.toString(), response.body);
    }
  }

  @override
  Future<DomainsModel> fetchDomains() async {
    final url = Uri.parse("https://api.mail.tm/domains?page=1");

    final response = await http.get(url);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = json.decode(response.body);

        return DomainsModel.fromJson(jsonBody);
      default:
        throw NetworkError(response.statusCode.toString(), response.body);
    }
  }

  @override
  Future<AccountModel> createAccount(String domain, String password) async {
    final randomAddress = generateRandomString(5);
    final randomDomain = domain;
    final randomEmail = "$randomAddress@$randomDomain";
    final payload = json.encode({"address": randomEmail, "password": password});
    final url = Uri.parse("https://api.mail.tm/accounts");

    final response = await http.post(url, body: payload, headers: {
      "Content-Type": "application/json",
    });

    switch (response.statusCode) {
      case HttpStatus.created:
        final jsonBody = json.decode(response.body);

        return AccountModel.fromJson(jsonBody);
      default:
        throw NetworkError(response.statusCode.toString(), response.body);
    }
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;

  NetworkError(this.statusCode, this.message);
}
