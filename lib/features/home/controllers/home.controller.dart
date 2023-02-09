import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
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
  _HomeViewControllerBase(
      this.accountRepository, this.accountStorage, this.dioService);

  @observable
  bool isLoading = false;

  @observable
  bool copied = false;

  @observable
  LocalAccount? account;

  ReactionDisposer? accountListener;

  final TextEditingController textFieldController = TextEditingController();

  Future<void> initState() async {
    final isLoggedIn = await accountStorage.isLoggedIn();

    accountListener = autorun((_) {
      if (account != null) {
        textFieldController.text = account!.address!;
      }
    });

    if (isLoggedIn) {
      account = await accountStorage.getAccount();
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
    account = LocalAccount(
        address: _account.address, password: password, token: token.token);

    await accountStorage.saveAccount(account!);

    textFieldController.text = account!.address!;

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

    if (account != null) {
      Clipboard.setData(ClipboardData(text: account?.address)).then((value) {
        Future.delayed(const Duration(milliseconds: 500), () => copied = false);
      });
    }
  }

  dispose() {
    accountListener!();
  }
}

void disposeHomeViewController(HomeViewController instance) {
  instance.dispose();
}
