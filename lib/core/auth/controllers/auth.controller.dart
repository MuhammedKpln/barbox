import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:spamify/isar/local_account.db.dart';
import 'package:spamify/storage/account.storage.dart';
import 'package:spamify/storage/messages.storage.dart';
part 'auth.controller.g.dart';

enum AuthState { loggedIn, none }

@LazySingleton()
class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  _AuthControllerBase(this.accountStorage, this.messagesStorage);
  final AccountStorage accountStorage;
  final MessagesStorage messagesStorage;

  @observable
  AuthState authState = AuthState.none;

  @observable
  LocalAccount? account;

  Future<void> init() async {
    final isLoggedIn = await accountStorage.isLoggedIn();

    if (isLoggedIn) {
      authState = AuthState.loggedIn;
      account = await accountStorage.getAccount();
    }
  }

  Future<void> logout() async {
    await accountStorage.removeAccount();
    await messagesStorage.clear();

    account = null;
    authState = AuthState.none;
  }
}
