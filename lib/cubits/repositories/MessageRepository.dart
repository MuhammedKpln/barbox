import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:spamify/types/message.dart';

abstract class MessageRepository {
  Future<MessageSingle> getMessage(String messageId, String token);
}

class MessageRepo implements MessageRepository {
  @override
  Future<MessageSingle> getMessage(String messageId, String token) async {
    final url = Uri.parse('https://api.mail.tm/messages/${messageId}');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer ${token}'});

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = jsonDecode(response.body);

        return MessageSingle.fromJson(jsonBody);

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
