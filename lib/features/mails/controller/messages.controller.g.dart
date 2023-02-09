// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessagesController on _MessagesControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_MessagesControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$messagesAtom =
      Atom(name: '_MessagesControllerBase.messages', context: context);

  @override
  List<Message> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(List<Message> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$showingMessageAtom =
      Atom(name: '_MessagesControllerBase.showingMessage', context: context);

  @override
  SingleMessage? get showingMessage {
    _$showingMessageAtom.reportRead();
    return super.showingMessage;
  }

  @override
  set showingMessage(SingleMessage? value) {
    _$showingMessageAtom.reportWrite(value, super.showingMessage, () {
      super.showingMessage = value;
    });
  }

  late final _$isFetchingSingleMessageAtom = Atom(
      name: '_MessagesControllerBase.isFetchingSingleMessage',
      context: context);

  @override
  bool get isFetchingSingleMessage {
    _$isFetchingSingleMessageAtom.reportRead();
    return super.isFetchingSingleMessage;
  }

  @override
  set isFetchingSingleMessage(bool value) {
    _$isFetchingSingleMessageAtom
        .reportWrite(value, super.isFetchingSingleMessage, () {
      super.isFetchingSingleMessage = value;
    });
  }

  late final _$selectedMessagesAtom =
      Atom(name: '_MessagesControllerBase.selectedMessages', context: context);

  @override
  ObservableList<Message> get selectedMessages {
    _$selectedMessagesAtom.reportRead();
    return super.selectedMessages;
  }

  @override
  set selectedMessages(ObservableList<Message> value) {
    _$selectedMessagesAtom.reportWrite(value, super.selectedMessages, () {
      super.selectedMessages = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_MessagesControllerBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$fetchMessageAsyncAction =
      AsyncAction('_MessagesControllerBase.fetchMessage', context: context);

  @override
  Future fetchMessage(Message message) {
    return _$fetchMessageAsyncAction.run(() => super.fetchMessage(message));
  }

  late final _$_MessagesControllerBaseActionController =
      ActionController(name: '_MessagesControllerBase', context: context);

  @override
  bool toggleMessageCheckbox(Message message) {
    final _$actionInfo = _$_MessagesControllerBaseActionController.startAction(
        name: '_MessagesControllerBase.toggleMessageCheckbox');
    try {
      return super.toggleMessageCheckbox(message);
    } finally {
      _$_MessagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteMessages() {
    final _$actionInfo = _$_MessagesControllerBaseActionController.startAction(
        name: '_MessagesControllerBase.deleteMessages');
    try {
      return super.deleteMessages();
    } finally {
      _$_MessagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
messages: ${messages},
showingMessage: ${showingMessage},
isFetchingSingleMessage: ${isFetchingSingleMessage},
selectedMessages: ${selectedMessages}
    ''';
  }
}
