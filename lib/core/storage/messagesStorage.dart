import 'package:injectable/injectable.dart';

const messagesBox = "messagesBox";

@LazySingleton()
class MessageStorage {}

// void storeMessages(MessagesModel _messages) {
//   final _messagesBox = Hive.box(messagesBox);
//   final messages = _messagesBox.get("messages");

//   if (messages == null) {
//     _messagesBox.put("messages", json.encode(_messages.toJson()));
//   }
// }

// void addNewMessage(HydraMember _message) {
//   final box = Hive.box(messagesBox);
//   final messages = box.get("messages");
//   final messageModel = MessagesModel.fromJson(json.decode(messages));
//   messageModel.hydraMember?.add(_message);
//   messageModel.hydraTotalItems += 1;

//   box.put("messages", json.encode(messageModel.toJson()));
// }

// void markMessageAsSeen(String _messageId) {
//   final box = Hive.box(messagesBox);
//   final messages = box.get("messages");
//   final messageModel = MessagesModel.fromJson(json.decode(messages));
//   final seenMessage = messageModel.hydraMember
//       ?.firstWhere((element) => element.id == _messageId);
//   seenMessage!.seen = true;

//   box.put("messages", json.encode(messageModel.toJson()));
// }

// getCachedMessages() {
//   final box = Hive.box(messagesBox);
//   final messages = box.get("messages");
//   if (messages != null) {
//     final messagesModel = MessagesModel.fromJson(json.decode(messages));
//     return messagesModel;
//   }

//   return MessagesModel(hydraMember: [], hydraTotalItems: 0);
// }

// deleteCachedMessage(String messageId) {
//   final box = Hive.box(messagesBox);
//   final messages = box.get("messages");
//   final messageModel = MessagesModel.fromJson(json.decode(messages));
//   messageModel.hydraMember?.removeWhere((element) => element.id == messageId);

//   box.put("messages", json.encode(messageModel.toJson()));
// }

// deleteAllCachedMessage() {
//   final box = Hive.box(messagesBox);

//   box.clear();
// }