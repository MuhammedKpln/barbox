import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:spamify/config.dart';
import 'package:spamify/core/services/dio.service.dart';
import 'package:spamify/types/messages/messages.dart';
import 'package:spamify/types/single_message/single_message.dart';

abstract class MessagesRespositoryBase {
  Future<Messages> fetchMessages();
  Future<SingleMessage> fetchMessage(String messageId);
  Future<bool> deleteMessage(String messageId);
  //Future<bool> deleteMessages(List<HydraMember>? messages);
}

@LazySingleton()
class MessagesRepository implements MessagesRespositoryBase {
  final url = Uri.parse("$API_URL/messages");
  final DioService _api;

  MessagesRepository(this._api);

  @override
  Future<Messages> fetchMessages() async {
    final request = await _api.get("/messages");
    final data = Messages.fromMap(request?.data);

    return data;
  }

  @override
  Future<SingleMessage> fetchMessage(String messageId) async {
    final request = await _api.get("/messages/$messageId");
    final data = SingleMessage.fromMap(request?.data);

    return data;
  }

  @override
  Future<bool> deleteMessage(String messageId) async {
    final request = await _api.delete("/messages/$messageId");

    return request?.statusCode == HttpStatus.noContent ? true : false;
  }
}
