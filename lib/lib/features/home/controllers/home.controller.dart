import 'package:barbox/core/services/router/router.service.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:barbox/core/auth/controllers/auth.controller.dart';
import 'package:barbox/core/storage/app.storage.dart';
import 'package:barbox/utils.dart';

part 'home.controller.g.dart';

@LazySingleton(dispose: disposeHomeViewController)
class HomeViewController = _HomeViewControllerBase with _$HomeViewController;

abstract class _HomeViewControllerBase with Store {
  final AuthController _authController;
  final AppStorage _appStorage;

  _HomeViewControllerBase(this._authController, this._appStorage);

  @observable
  Observable<bool> shouldShowWelcomeSheet = Observable(false);

  @action
  Future<void> initState() async {
    final didShowWelcomeSheet = await _appStorage.getDidShowWelcomeSheet();
    if (didShowWelcomeSheet == null) {
      shouldShowWelcomeSheet.value = true;
    } else if (didShowWelcomeSheet == false) {
      shouldShowWelcomeSheet.value = true;
    }

    if (_authController.isLoggedIn) {
      appRouterDelegate.beamToNamed(RouterMeta.inbox.path);
    }
  }

  @action
  Future<void> closeHomeSheet(BuildContext context) async {
    final randomString = generateRandomString(10);
    await _appStorage.setDidShowWelcomeSheet(true);
    await _authController.register(
        username: randomString,
        password: randomString,
        selectedDomain: "eurokool.com");
    Navigator.of(context).pop();

    context.beamToNamed(RouterMeta.inbox.path);
  }

  dispose() {}
}

void disposeHomeViewController(HomeViewController instance) {
  instance.dispose();
}
