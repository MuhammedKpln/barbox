import 'package:barbox/core/storage/isar/base.db.dart';
import 'package:barbox/core/storage/isar/local_account.db.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@LazySingleton()
class AccountStorage {
  Future<void> saveAccount(LocalAccount account) async {
    isarInstance.writeAsync((isar) async {
      isar.localAccounts.put(account);
    });
  }

  Future<void> removeAccount(LocalAccount account) async {
    isarInstance.writeAsync((isar) async {
      isar.localAccounts.delete(account.id);
    });
  }

  Future<void> removeAllAccounts() async {
    isarInstance.writeAsync((isar) async {
      isar.localAccounts.clear();
    });
  }

  Future<LocalAccount?> getAccount({required String accountId}) async {
    return isarInstance.localAccounts
        .where()
        .accountIdEqualTo(accountId)
        .findFirstAsync();
  }

  Future<List<LocalAccount>> getAllAvailableAccounts() async {
    return isarInstance.localAccounts.where().findAllAsync();
  }

  Future<bool> isLoggedIn() async {
    final exists = await getAllAvailableAccounts();

    if (exists.isNotEmpty) {
      return true;
    }

    return false;
  }
}
