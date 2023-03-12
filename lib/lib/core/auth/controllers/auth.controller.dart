import 'dart:async';

import 'package:barbox/core/services/di.service.dart';
import 'package:barbox/features/home/repositories/account.repository.dart';
import 'package:barbox/utils.dart';
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
  ObservableList<LocalAccount> availableAccounts = ObservableList();

  @computed
  bool get isLoggedIn => authState.value == AuthState.loggedIn;

  @action
  Future<void> init() async {
    final _accounts = await _accountStorage.getAllAvailableAccounts();
    availableAccounts = ObservableList.of(_accounts);

    if (_accounts.isNotEmpty) {
      account.value = availableAccounts.last;
      authState.value = AuthState.loggedIn;
    }
  }

  @action
  Future<void> logout() async {
    await _accountStorage.removeAccount(account.value!);
    await _messagesStorage.clearMessagesByAddress(account.value!);

    availableAccounts.removeWhere((element) => element.id == account.value!.id);
    account.value = null;

    if (availableAccounts.isEmpty) {
      authState.value = AuthState.none;
    } else {
      account.value = availableAccounts.last;
    }
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
    availableAccounts.add(account.value!);
    authState.value = AuthState.loggedIn;
  }

  @action
  Future<void> switchAccount(int id) async {
    final toAccount = await _accountStorage.getAccount(id: id);
    account.value = toAccount;
  }

  Future<bool> register(
      {required String username,
      required String selectedDomain,
      required String password}) async {
    try {
      final _accountRepository = getIt<AccountRepository>();
      final address = "$username@$selectedDomain";

      final _account =
          await _accountRepository.createAccount(address, password);

      final token = await _accountRepository.login(_account.address, password);

      await login(acc: _account, password: password, token: token.token);

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerWithRandomUsername() async {
    final _accountRepository = getIt<AccountRepository>();
    final domains = await _accountRepository.fetchDomains();
    final randomString = generateRandomString(10);

    await register(
      username: randomString,
      selectedDomain: domains.hydraMember.last.domain,
      password: randomString,
    );
  }
}
