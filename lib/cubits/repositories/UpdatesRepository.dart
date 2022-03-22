import 'dart:convert';
import 'dart:io';

import 'package:spamify/cubits/repositories/MessageRepository.dart';

import 'package:http/http.dart' as http;
import 'package:spamify/types/updates.dart';

abstract class UpdatesRepository {
  Future<UpdateModel> checkForUpdates();
}

class UpdatesRepo implements UpdatesRepository {
  @override
  Future<UpdateModel> checkForUpdates() async {
    final url = Uri.parse(
        "https://raw.githubusercontent.com/MuhammedKpln/spamify/main/updates.json");
    final response = await http.get(url);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = json.decode(response.body);

        return UpdateModel.fromJson(jsonBody);
      default:
        throw NetworkError(response.statusCode.toString(), response.body);
    }
  }
}
