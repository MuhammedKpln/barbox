import 'dart:async';

import 'package:barbox/core/auth/controllers/auth.controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:barbox/core/services/notification.service.dart';
import 'package:barbox/core/storage/account.storage.dart';
import 'package:barbox/features/mails/repositories/messages.repository.dart';
import 'package:barbox/core/storage/messages.storage.dart';
import 'package:barbox/types/messages/message.dart';
import 'package:barbox/types/single_message/single_message.dart';

part 'messages.controller.g.dart';

@LazySingleton(dispose: disposeMessagesViewController)
class MessagesController = _MessagesControllerBase with _$MessagesController;

abstract class _MessagesControllerBase with Store {
  _MessagesControllerBase(this._messagesRepository, this._messagesStorage,
      this._notificationService, this._accountStorage, this._authController);

  final MessagesRepository _messagesRepository;
  final MessagesStorage _messagesStorage;
  final NotificationService _notificationService;
  final AccountStorage _accountStorage;
  final AuthController _authController;

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
  bool selectMode = false;

  final _cancelToken = CancelToken();

  StreamSubscription? _newMessagesStream;

  ReactionDisposer? _selectModeWatcher;

  @action
  init() async {
    await fetchLocalMessages();
    await fetchMessages();
    await listenToNewMessages();

    _selectModeWatcher = autorun((_) {
      if (!selectMode) {
        selectedMessages.clear();
      }
    });
  }

  Future<void> listenToNewMessages() async {
    final _messages = _messagesWithoutStream;
    final account = await _accountStorage.getAccount();
    final String accountId = account!.accountId!;

    final stream =
        await _messagesRepository.listenToNewMessages(_cancelToken, accountId);

    _newMessagesStream = stream.listen((message) {
      final isAlreadyExists =
          _messagesWithoutStream.indexWhere((msg) => msg.id == message.id) !=
              -1;

      // Message already exists, update it.
      if (isAlreadyExists) {
        // Deleted.
        if (message.isDeleted) {
          _messagesWithoutStream
              .removeWhere((element) => element.id == message.id);
          messages.sink.add(_messages);

          return;
        }

        final index =
            _messagesWithoutStream.indexWhere((msg) => msg.id == message.id);
        _messagesWithoutStream[index] = message;
        messages.sink.add(_messages);
        return;
      }

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
          await _messagesStorage.deleteMessage(message.isarId);
        }
      });
    }

    messages.sink.add(_messagesWithoutStream);
  }

  @action
  Future<void> bulkMarkAsSeen() async {
    for (var message in selectedMessages) {
      final isSeen = await _messagesRepository.markAsSeen(message.id, true);

      await _messagesStorage.updateMessageSeen(message.id, isSeen);
    }

    selectMode = false;
  }

  @action
  toggleSelectMode() {
    selectMode = !selectMode;

    if (!selectMode) {
      selectedMessages.clear();
    }
  }

  Future<void> copyAddress() async {
    final clipboardData =
        ClipboardData(text: _authController.account.value?.address);

    await Clipboard.setData(clipboardData);
  }

  dispose() {
    _cancelToken.cancel();
    _newMessagesStream?.cancel();
    _selectModeWatcher?.call();
  }
}

disposeMessagesViewController(MessagesController instance) {
  instance.dispose();
}
