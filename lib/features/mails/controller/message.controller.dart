import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:barbox/core/storage/messages.storage.dart';
import 'package:barbox/features/mails/repositories/messages.repository.dart';
import 'package:barbox/types/single_message/single_message.dart';
import 'package:url_launcher/url_launcher.dart';

part 'message.controller.g.dart';

@LazySingleton()
class MessageController = _MessageControllerBase with _$MessageController;

abstract class _MessageControllerBase with Store {
  _MessageControllerBase(this.messagesRepository, this.messagesStorage);

  MessagesRepository messagesRepository;
  MessagesStorage messagesStorage;

  @observable
  SingleMessage? message;

  @observable
  bool isLoading = true;

  Future<void> init({required String msgId}) async {
    await _fetchMessage(msgId);
    await _markAsSeen(msgId);
  }

  Future<void> _markAsSeen(String msgId) async {
    final isSeen = await messagesRepository.markAsSeen(msgId, true);

    await messagesStorage.updateMessageSeen(message!.id, isSeen);
  }

  FutureOr<bool> onTapUrl(String url) async {
    final uri = Uri.parse(url);

    await canLaunchUrl(uri)
        ? launchUrl(uri, mode: LaunchMode.externalApplication)
        : false;

    return true;
  }

  @action
  _fetchMessage(String msgId) async {
    final messageFromRepo = await messagesRepository.fetchMessage(msgId);
    message = messageFromRepo;
    isLoading = false;
  }
}
