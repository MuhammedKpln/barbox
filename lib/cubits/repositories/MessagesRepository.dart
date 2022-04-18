import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:spamify/cubits/repositories/MessageRepository.dart';
import 'package:spamify/types/messages.dart';

abstract class MessagesRespository {
  Future<MessagesModel> getMessages(String token);
  Future<bool> deleteMessage(String messageId, String token);
  Future<bool> deleteMessages(List<HydraMember>? messages, String token);
}

class MessagesRepo implements MessagesRespository {
  final url = Uri.parse("https://api.mail.tm/messages?page=1");

  @override
  getMessages(String token) async {
    final response = await http.get(
        Uri.parse("https://api.mail.tm/messages?page=1"),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == HttpStatus.ok) {
      return MessagesModel.fromJson(json.decode(response.body));
    } else {
      throw NetworkError(
          response.statusCode.toString(), "Could not load mails");
    }
  }

  @override
  deleteMessage(String messageId, String token) async {
    final response = await http.delete(
        Uri.parse("https://api.mail.tm/messages/$messageId"),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == HttpStatus.noContent) {
      return true;
    } else {
      throw NetworkError(
          response.statusCode.toString(), "Could not load mails");
    }
  }

  @override
  Future<bool> deleteMessages(List<HydraMember>? messages, String token) async {
    List<HydraMember> messagesDeleted = [];

    if (messages!.isNotEmpty) {
      messages.forEach((element) async {
        final response = await http.delete(
            Uri.parse("https://api.mail.tm/messages/${element.id}"),
            headers: {"Authorization": "Bearer $token"});
        if (response.statusCode == HttpStatus.noContent) {
          messagesDeleted.add(element);
        } else {
          print(response.statusCode);
          throw NetworkError(
              response.statusCode.toString(), "Could not load mails");
        }
      });

      if (messagesDeleted.length == messages.length) {
        return true;
      }

      return false;
    }

    return false;
  }
}
