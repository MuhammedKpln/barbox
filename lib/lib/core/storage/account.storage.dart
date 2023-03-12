import 'package:injectable/injectable.dart';
import 'package:barbox/core/storage/isar/base.db.dart';
import 'package:barbox/core/storage/isar/local_account.db.dart';
import 'package:isar/isar.dart';

@LazySingleton()
class AccountStorage {
  Future<void> saveAccount(LocalAccount account) async {
    isarInstance.writeTxn(() async {
      await isarInstance.localAccounts.put(account);
    });
  }

  Future<void> removeAccount(LocalAccount account) async {
    isarInstance.writeTxn(() async {
      await isarInstance.localAccounts.delete(account.id);
    });
  }

  Future<void> removeAllAccounts() async {
    isarInstance.writeTxn(() async {
      await isarInstance.localAccounts.clear();
    });
  }

  Future<LocalAccount?> getAccount({int? id}) async {
    return isarInstance.localAccounts.get(id ?? 1);
  }

  Future<List<LocalAccount>> getAllAvailableAccounts() async {
    return isarInstance.localAccounts.where().findAll();
  }

  Future<bool> isLoggedIn() async {
    final exists = await getAllAvailableAccounts();

    if (exists.isNotEmpty) {
      return true;
    }

    return false;
  }
}
