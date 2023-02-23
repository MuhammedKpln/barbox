import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:spamify/core/auth/controllers/auth.controller.dart';
import 'package:spamify/core/storage/isar/local_account.db.dart';
import 'package:spamify/features/home/repositories/account.repository.dart';
import 'package:spamify/core/services/dio.service.dart';
import 'package:spamify/core/storage/account.storage.dart';
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
    authController.authState.observe((value) {
      if (value.newValue == AuthState.loggedIn) {
        textFieldController.text = authController.account.value?.address ?? "";
      }
      if (value.newValue == AuthState.none) {
        textFieldController.text = "";
      }
    });
  }

  @action
  Future<void> fetchNewAdress() async {
    isLoading = true;
    final password = generateRandomString(10);

    final domains = await accountRepository.fetchDomains();
    final _account = await accountRepository.createAccount(
        domains.hydraMember[0].domain, password);

    final token = await accountRepository.login(_account.address, password);
    authController.account.value = LocalAccount(
        address: _account.address, password: password, token: token.token);

    await accountStorage.saveAccount(authController.account.value!);
    authController.authState.value = AuthState.loggedIn;

    textFieldController.text = authController.account.value?.address ?? "";

    isLoading = false;
  }

  @action
  Future<void> copyEmailAddress() async {
    copied = true;

    Clipboard.setData(
            ClipboardData(text: authController.account.value?.address))
        .then((value) {
      Future.delayed(const Duration(milliseconds: 500), () => copied = false);
    });
  }

  dispose() {}
}

void disposeHomeViewController(HomeViewController instance) {
  instance.dispose();
}
