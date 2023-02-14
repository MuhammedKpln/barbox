import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:spamify/core/auth/controllers/auth.controller.dart';
import 'package:spamify/features/home/repositories/account.repository.dart';
import 'package:spamify/isar/local_account.db.dart';
import 'package:spamify/services/dio.service.dart';
import 'package:spamify/storage/account.storage.dart';
import 'package:spamify/utils.dart';

part 'home.controller.g.dart';

@LazySingleton(dispose: disposeHomeViewController)
class HomeViewController = _HomeViewControllerBase with _$HomeViewController;

abstract class _HomeViewControllerBase with Store {
  final AccountRepository accountRepository;
  final AccountStorage accountStorage;
  final DioService dioService;
  final AuthController authController;

  _HomeViewControllerBase(this.accountRepository, this.accountStorage,
      this.dioService, this.authController);

  @observable
  bool isLoading = false;

  @observable
  bool copied = false;

  final TextEditingController textFieldController = TextEditingController();

  Future<void> initState() async {
    await authController.init();

    if (authController.authState == AuthState.loggedIn) {
      textFieldController.text = authController.account!.address!;
    }
  }

  @action
  Future<void> fetchNewAdress() async {
    isLoading = true;
    // try {
    final password = generateRandomString(10);

    final domains = await accountRepository.fetchDomains();
    final _account = await accountRepository.createAccount(
        domains.hydraMember[0].domain, password);

    final token = await accountRepository.login(_account.address, password);
    authController.account = LocalAccount(
        address: _account.address, password: password, token: token.token);

    await accountStorage.saveAccount(authController.account!);

    textFieldController.text = authController.account!.address!;

    isLoading = false;
    // } catch (e) {
    //   print(e);
    // }
  }

  @action
  Future<void> login(String address, String password) async {
    isLoading = true;
    try {
      final _account = await accountRepository.login(address, password);
      final account = LocalAccount(
          address: address, password: password, token: _account.token);
    } catch (e) {
      rethrow;
    }
  }

  @action
  Future<void> copyEmailAddress() async {
    copied = true;

    if (authController.account != null) {
      Clipboard.setData(ClipboardData(text: authController.account?.address))
          .then((value) {
        Future.delayed(const Duration(milliseconds: 500), () => copied = false);
      });
    }
  }

  dispose() {}
}

void disposeHomeViewController(HomeViewController instance) {
  instance.dispose();
}
