import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:barbox/core/storage/account.storage.dart';
import 'package:barbox/core/storage/isar/local_account.db.dart';
import 'package:barbox/core/storage/messages.storage.dart';
import 'package:barbox/types/account.dart';
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

  @observable
  List<LocalAccount>? availableAccounts;

  @computed
  bool get isLoggedIn => authState.value == AuthState.loggedIn;

  @action
  Future<void> init() async {
    availableAccounts = await _accountStorage.getAllAvailableAccounts();
    final isLoggedIn = await _accountStorage.isLoggedIn();

    if (isLoggedIn) {
      account.value = await _accountStorage.getAccount();
      authState.value = AuthState.loggedIn;
    }
  }

  @action
  Future<void> logout() async {
    await _accountStorage.removeAccount();
    await _messagesStorage.clear();

    account.value = null;
    authState.value = AuthState.none;
  }

  @action
  Future<void> login(
      {required AccountModel acc,
      required String password,
      required String token}) async {
    account.value = LocalAccount(
      address: acc.address,
      password: password,
      token: token,
      accountId: acc.id,
    );

    await _accountStorage.saveAccount(account.value!);
    authState.value = AuthState.loggedIn;
  }

  Future<void> _cleanUpIfAccountAlreadyExists() async {
    if (isLoggedIn) {
      await logout();
    }
  }

  @action
  Future<void> switchAccount(int id) async {
    final toAccount = await _accountStorage.getAccount(id: id);
    account.value = toAccount;
  }
}
