import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:barbox/core/auth/controllers/auth.controller.dart';
import 'package:barbox/core/storage/app.storage.dart';
import 'package:barbox/features/home/repositories/account.repository.dart';
import 'package:barbox/core/services/dio.service.dart';
import 'package:barbox/core/storage/account.storage.dart';
import 'package:barbox/utils.dart';

part 'home.controller.g.dart';

@LazySingleton(dispose: disposeHomeViewController)
class HomeViewController = _HomeViewControllerBase with _$HomeViewController;

abstract class _HomeViewControllerBase with Store {
  final AccountRepository _accountRepository;
  final AccountStorage _accountStorage;
  final DioService _dioService;
  final AuthController _authController;
  final AppStorage _appStorage;

  _HomeViewControllerBase(this._accountRepository, this._accountStorage,
      this._dioService, this._authController, this._appStorage);

  @observable
  bool isLoading = false;

  @observable
  bool copied = false;

  @observable
  Observable<bool> shouldShowWelcomeSheet = Observable(false);

  final TextEditingController textFieldController = TextEditingController();

  @action
  Future<void> initState() async {
    final didShowWelcomeSheet = await _appStorage.getDidShowWelcomeSheet();

    if (didShowWelcomeSheet == null) {
      shouldShowWelcomeSheet.value = true;
    } else if (didShowWelcomeSheet == false) {
      shouldShowWelcomeSheet.value = true;
    }

    _authController.authState.observe((value) {
      if (value.newValue == AuthState.loggedIn) {
        textFieldController.text = _authController.account.value?.address ?? "";
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

    final domains = await _accountRepository.fetchDomains();
    final _account = await _accountRepository.createAccount(
        domains.hydraMember[0].domain, password);

    final token = await _accountRepository.login(_account.address, password);

    await _authController.login(
        acc: _account, password: password, token: token.token);

    textFieldController.text = _account.address;

    isLoading = false;
  }

  @action
  Future<void> copyEmailAddress() async {
    copied = true;

    Clipboard.setData(
            ClipboardData(text: _authController.account.value?.address))
        .then((value) {
      Future.delayed(const Duration(milliseconds: 500), () => copied = false);
    });
  }

  @action
  Future<void> closeHomeSheet(BuildContext context) async {
    await _appStorage.setDidShowWelcomeSheet(true);

    Navigator.of(context).pop();
  }

  dispose() {}
}

void disposeHomeViewController(HomeViewController instance) {
  instance.dispose();
}
