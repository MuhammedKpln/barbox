import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:spamify/config.dart';
import 'package:spamify/features/settings/models/update.model.dart';

@LazySingleton()
class UpdateRepository {
  Future<Updates> fetchUpdate() async {
    const url = CHECK_FOR_UPDATE_URL;

    final response = await Dio().get(url);

    return Updates.fromJson(json.decode(response.data));
  }
}
