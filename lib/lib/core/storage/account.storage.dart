import 'package:injectable/injectable.dart';
import 'package:barbox/core/storage/isar/base.db.dart';
import 'package:barbox/core/storage/isar/local_account.db.dart';

@LazySingleton()
class AccountStorage {
  Future<void> saveAccount(LocalAccount account) async {
    isarInstance.writeTxn(() async {
      await isarInstance.localAccounts.put(account);
    });
  }

  Future<void> removeAccount() async {
    isarInstance.writeTxn(() async {
      await isarInstance.localAccounts.clear();
    });
  }

  Future<LocalAccount?> getAccount() async {
    final count = await isarInstance.localAccounts.count();

    return isarInstance.localAccounts.get(count);
  }

  Future<bool> isLoggedIn() async {
    final exists = await getAccount();

    if (exists != null) {
      return true;
    }

    return false;
  }
}
