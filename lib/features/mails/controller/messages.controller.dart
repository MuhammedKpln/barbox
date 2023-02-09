import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:mobx/mobx.dart';
import 'package:spamify/features/mails/models/message.model.dart';
import 'package:spamify/features/mails/models/single_message.model.dart';
import 'package:spamify/features/mails/repositories/messages.repository.dart';
import 'package:url_launcher/url_launcher.dart';

part 'messages.controller.g.dart';

@LazySingleton()
class MessagesController = _MessagesControllerBase with _$MessagesController;

abstract class _MessagesControllerBase with Store {
  _MessagesControllerBase(this.messagesRepository);

  MessagesRepository messagesRepository;

  @observable
  bool isLoading = true;

  @observable
  List<Message> messages = [];

  @observable
  SingleMessage? showingMessage;

  @observable
  bool isFetchingSingleMessage = false;

  @observable
  ObservableList<Message> selectedMessages = ObservableList.of([]);

  @observable
  bool deleteMode = false;

  @action
  init() async {
    final messagesFromRepo = await messagesRepository.fetchMessages();

    if (messagesFromRepo.hydraTotalItems > 0) {
      messages = messagesFromRepo.hydraMember.toList();
    }
  }

  @action
  fetchMessage(Message message) async {
    isFetchingSingleMessage = true;
    final messageFromRepo =
        await messagesRepository.fetchMessage(message.hydraMemberId);

    showingMessage = messageFromRepo;
    isFetchingSingleMessage = false;
  }

  @action
  void toggleMessageCheckbox(Message message) {
    final contains = selectedMessages.contains(message);

    if (contains) {
      selectedMessages.remove(message);
      return;
    }

    selectedMessages.add(message);
  }

  @action
  deleteMessages() {
    print(selectedMessages);
  }

  FutureOr<bool> onTapUrl(String url) async {
    final uri = Uri.parse(url);

    await canLaunchUrl(uri)
        ? launchUrl(uri, mode: LaunchMode.externalApplication)
        : false;

    return true;
  }

  @action
  toggleDeleteMode() {
    deleteMode = !deleteMode;
  }
}
