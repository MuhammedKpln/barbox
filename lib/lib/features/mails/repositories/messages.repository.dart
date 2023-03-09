import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:barbox/config.dart';
import 'package:barbox/core/services/dio.service.dart';
import 'package:barbox/types/messages/message.dart';
import 'package:barbox/types/messages/messages.dart';
import 'package:barbox/types/single_message/single_message.dart';

abstract class MessagesRespositoryBase {
  Future<Messages> fetchMessages();
  Future<SingleMessage> fetchMessage(String messageId);
  Future<bool> deleteMessage(String messageId);
  Future<bool> markAsSeen(String messageId, bool seen);
  Future<Stream<Message>> listenToNewMessages(
      CancelToken cancelToken, String accountId, String authToken);
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

  @override
  Future<bool> markAsSeen(String messageId, bool seen) async {
    final request =
        await _api.patch("/messages/$messageId", data: {"seen": seen});

    return request?.data?["seen"] as bool;
  }

  @override
  Future<Stream<Message>> listenToNewMessages(
      CancelToken cancelToken, String accountId, String authToken) async {
    final response = await _api.stream(
      path: SSE_API_URL,
      cancelToken: cancelToken,
      authToken: authToken,
      queryParams: {"topic": accountId},
    );

    StreamTransformer<Uint8List, List<int>> unit8Transformer =
        StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        sink.add(List<int>.from(data));
      },
    );

    final StreamTransformer<String, Message> toMessageObjectTransformer =
        StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        if (data.startsWith("data:")) {
          sink.add(Message.fromJson(data.substring(5)));
        }
      },
    );

    return response!.data.stream
        .transform(unit8Transformer)
        .transform(const Utf8Decoder())
        .transform(const LineSplitter())
        .transform(toMessageObjectTransformer);
  }
}
