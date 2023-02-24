import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:spamify/core/services/notification.service.dart';
import 'package:spamify/core/storage/account.storage.dart';
import 'package:spamify/features/mails/repositories/messages.repository.dart';
import 'package:spamify/core/storage/messages.storage.dart';
import 'package:spamify/types/messages/message.dart';
import 'package:spamify/types/single_message/single_message.dart';

part 'messages.controller.g.dart';

@LazySingleton(dispose: disposeMessagesViewController)
class MessagesController = _MessagesControllerBase with _$MessagesController;

abstract class _MessagesControllerBase with Store {
  _MessagesControllerBase(this._messagesRepository, this._messagesStorage,
      this._notificationService, this._accountStorage);

  final MessagesRepository _messagesRepository;
  final MessagesStorage _messagesStorage;
  final NotificationService _notificationService;
  final AccountStorage _accountStorage;

  @observable
  bool isLoading = true;

  @observable
  StreamController<List<Message>> messages = StreamController.broadcast();
  List<Message> _messagesWithoutStream = [];

  @observable
  SingleMessage? showingMessage;

  @observable
  bool isFetchingSingleMessage = false;

  @observable
  ObservableList<Message> selectedMessages = ObservableList.of([]);

  @observable
  bool deleteMode = false;

  final _cancelToken = CancelToken();

  StreamSubscription? _newMessagesStream;

  @action
  init() async {
    await fetchLocalMessages();
    await fetchMessages();
    await listenToNewMessages();
  }

  Future<void> listenToNewMessages() async {
    final _messages = _messagesWithoutStream;
    final account = await _accountStorage.getAccount();
    final String accountId = account!.accountId!;

    final stream =
        await _messagesRepository.listenToNewMessages(_cancelToken, accountId);

    _newMessagesStream = stream.listen((message) {
      _notificationService.showNotification(
        title: message.subject ?? "New mail arrived!",
        body: message.intro ?? "",
        payload: message.toJson(),
      );

      _saveMessageToDatabase(message);
      _messages.insert(0, message);
      messages.sink.add(_messages);
      _messagesWithoutStream = _messages;
    });
  }

  @action
  Future<void> fetchMessages() async {
    final messagesFromRepo = await _messagesRepository.fetchMessages();

    if (messagesFromRepo.hydraTotalItems > 0) {
      final _messages = messagesFromRepo.hydraMember.toList();
      final alreadyStored =
          await _messagesStorage.containsMessage(_messages[0]);

      if (!alreadyStored) {
        _notificationService.showNotification(
          title: _messages[0].subject ?? "New mail arrived!",
          body: _messages[0].intro ?? "",
          payload: _messages[0].toJson(),
        );

        _saveMessagesToDatabase(_messages);
        messages.sink.add(_messages);
        _messagesWithoutStream = _messages;
      }
    }
  }

  @action
  Future<void> fetchLocalMessages() async {
    final messagesFromRepo = await _messagesStorage.fetchMessages();

    messages.sink.add(messagesFromRepo);
    _messagesWithoutStream = messagesFromRepo;
  }

  Future<void> _saveMessagesToDatabase(List<Message> messages) async {
    for (var message in messages) {
      final contains = await _messagesStorage.containsMessage(message);

      if (!contains) {
        await _messagesStorage.saveMessage(message);
      }
    }
  }

  Future<void> _saveMessageToDatabase(Message message) async {
    await _messagesStorage.saveMessage(message);
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
  Future<void> deleteMessages() async {
    for (var message in selectedMessages) {
      await _messagesRepository.deleteMessage(message.id).then((ok) async {
        if (ok) {
          await _messagesStorage.deleteMessage(message.id);

          _messagesWithoutStream
              .removeWhere((element) => element.msgid == message.msgid);
        }
      });
    }

    messages.sink.add(_messagesWithoutStream);
  }

  @action
  toggleDeleteMode() {
    deleteMode = !deleteMode;

    if (!deleteMode) {
      selectedMessages.clear();
    }
  }

  dispose() {
    _cancelToken.cancel();
    _newMessagesStream?.cancel();
  }
}

disposeMessagesViewController(MessagesController instance) {
  instance.dispose();
}
