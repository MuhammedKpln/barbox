import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:spamify/types/messages.dart';

const messagesBox = "messagesBox";

void storeMessages(MessagesModel _messages) {
  final _messagesBox = Hive.box(messagesBox);
  final messages = _messagesBox.get("messages");
  final messagesListToJson = _messages.toJson();

  if (messages == null) {
    _messagesBox.put("messages", json.encode(messagesListToJson));
  }
}

void addNewMessage(HydraMember _message) {
  final box = Hive.box(messagesBox);
  final messages = box.get("messages");
  final messageModel = MessagesModel.fromJson(json.decode(messages));
  messageModel.hydraMember?.add(_message);
  messageModel.hydraTotalItems += 1;

  box.put("messages", json.encode(messageModel.toJson()));
}

getCachedMessages() {
  final box = Hive.box(messagesBox);
  final messages = box.get("messages");
  if (messages != null) {
    final messagesModel = MessagesModel.fromJson(json.decode(messages));

    return messagesModel;
  }
}
