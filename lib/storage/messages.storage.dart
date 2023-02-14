import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:spamify/features/mails/models/message.model.dart';
import 'package:spamify/isar/base.db.dart';
import 'package:spamify/isar/messages.db.dart';

@LazySingleton()
class MessagesStorage {
  Future<void> saveMessage(Message message) async {
    await isarInstance.writeTxn(() async {
      final entry = MessagesDatabase()
        ..accountId = message.accountId
        ..context = message.context
        ..createdAt = message.createdAt
        ..downloadUrl = message.downloadUrl
        ..from = MessageFromDb(
            address: message.from.address, name: message.from.name)
        ..hasAttachments = message.hasAttachments
        ..hydraMemberId = message.hydraMemberId
        ..id = message.id
        ..intro = message.intro
        ..intro = message.intro
        ..isDeleted = message.isDeleted
        ..msgid = message.msgid
        ..seen = message.seen
        ..size = message.size
        ..subject = message.subject
        ..to = message.to!
            .map((e) => MessageFromDb(address: e.address, name: e.name))
            .toList()
        ..type = message.type
        ..updatedAt = message.updatedAt;

      await isarInstance.messagesDatabases.put(entry);
    });
  }

  Future<void> saveMessages(List<MessagesDatabase> message) async {
    await isarInstance.writeTxn(() async {
      await isarInstance.messagesDatabases.putAll(message);
    });
  }

  Future<bool> containsMessage(Message message) async {
    final entries = await isarInstance.messagesDatabases
        .where()
        .msgidEqualTo(message.msgid)
        .count();

    if (entries > 0) {
      return true;
    }

    return false;
  }

  Future<List<MessagesDatabase>> fetchMessages() async {
    return isarInstance.messagesDatabases.where().findAll();
  }

  Future<void> deleteMessage(String messageId) async {
    return isarInstance.writeTxn(() async {
      await isarInstance.messagesDatabases
          .filter()
          .hydraMemberIdEqualTo(messageId)
          .deleteAll();
    });
  }

  Future<void> clear() async {
    return isarInstance.writeTxn(() async {
      await isarInstance.messagesDatabases.clear();
    });
  }
}
