import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:spamify/config.dart';
import 'package:spamify/features/mails/models/message.model.dart';
import 'package:spamify/features/mails/models/single_message.model.dart';
import 'package:spamify/services/dio.service.dart';

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
    final data = Messages.fromJson(request?.data);

    return data;
  }

  @override
  Future<SingleMessage> fetchMessage(String messageId) async {
    final request = await _api.get("/messages/$messageId");
    final data = SingleMessage.fromJson(request?.data);

    return data;
  }

  @override
  Future<bool> deleteMessage(String messageId) async {
    final request = await _api.get("/messages/$messageId");

    return request?.statusCode == HttpStatus.noContent ? true : false;
  }
}
