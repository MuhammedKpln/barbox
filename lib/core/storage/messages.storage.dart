import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:spamify/core/storage/isar/base.db.dart';
import 'package:spamify/types/messages/message.dart';

@LazySingleton()
class MessagesStorage {
  Future<void> saveMessage(Message message) async {
    await isarInstance.writeTxn(() async {
      await isarInstance.messages.put(message);
    });
  }

  Future<void> saveMessages(List<Message> message) async {
    await isarInstance.writeTxn(() async {
      await isarInstance.messages.putAll(message);
    });
  }

  //Isar's put() method will either insert or update the object depending on
  //whether it already exists in the collection.
  Future<void> updateMessageSeen(String msgId, bool seen) async {
    await isarInstance.writeTxn(() async {
      Message? message = await isarInstance.messages.getById(msgId);

      if (message != null) {
        message = message.copyWith(seen: seen);
        await isarInstance.messages.putById(message);
      }
    });
  }

  Future<bool> containsMessage(Message message) async {
    final entries =
        await isarInstance.messages.where().idEqualTo(message.id).count();

    if (entries > 0) {
      return true;
    }

    return false;
  }

  Future<List<Message>> fetchMessages() async {
    return isarInstance.messages.where().findAll();
  }

  Future<void> deleteMessage(String messageId) async {
    return isarInstance.writeTxn(() async {
      await isarInstance.messages.filter().idEqualTo(messageId).deleteAll();
    });
  }

  Future<void> clear() async {
    return isarInstance.writeTxn(() async {
      await isarInstance.messages.clear();
    });
  }
}
