import 'package:barbox/core/storage/isar/local_account.db.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:barbox/core/storage/isar/base.db.dart';
import 'package:barbox/types/messages/message.dart';

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

  Future<List<Message>> fetchMessages(String accountId) async {
    return isarInstance.messages.where().accountIdEqualTo(accountId).findAll();
  }

  Future<void> deleteMessage(int isarId) async {
    return isarInstance.writeTxn(() async {
      await isarInstance.messages.delete(isarId);
    });
  }

  Future<void> clear() async {
    return isarInstance.writeTxn(() async {
      await isarInstance.messages.clear();
    });
  }

  Future<void> clearMessagesByAddress(LocalAccount account) async {
    return isarInstance.writeTxn(() async {
      await isarInstance.messages
          .where()
          .accountIdEqualTo(account.accountId!)
          .deleteAll();
    });
  }
}
