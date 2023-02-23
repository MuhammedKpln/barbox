import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:spamify/core/storage/account.storage.dart';
import 'package:spamify/core/storage/isar/local_account.db.dart';
import 'package:spamify/core/storage/messages.storage.dart';
part 'auth.controller.g.dart';

enum AuthState { loggedIn, none }

@LazySingleton()
class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  _AuthControllerBase(this._accountStorage, this._messagesStorage);
  final AccountStorage _accountStorage;
  final MessagesStorage _messagesStorage;

  @observable
  Observable<AuthState> authState = Observable(AuthState.none);

  @observable
  Observable<LocalAccount?> account = Observable(null);

  @computed
  bool get isLoggedIn => authState.value == AuthState.loggedIn;

  @action
  Future<void> init() async {
    final isLoggedIn = await _accountStorage.isLoggedIn();

    if (isLoggedIn) {
      authState.value = AuthState.loggedIn;
      account.value = await _accountStorage.getAccount();
    }
  }

  @action
  Future<void> logout() async {
    await _accountStorage.removeAccount();
    await _messagesStorage.clear();

    account.value = null;
    authState.value = AuthState.none;
  }
}
