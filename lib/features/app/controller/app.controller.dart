import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:spamify/core/auth/controllers/auth.controller.dart';
import 'package:spamify/core/services/notification.service.dart';
import 'package:spamify/features/app/views/components/sidebarItem.component.dart';
import 'package:spamify/core/services/router/router.service.dart';
import 'package:spamify/core/storage/account.storage.dart';

part 'app.controller.g.dart';

@LazySingleton()
class AppViewController = _AppViewControllerBase with _$AppViewController;

abstract class _AppViewControllerBase with Store {
  _AppViewControllerBase(
      this.accountStorage, this.authController, this._notificationService);

  final AccountStorage accountStorage;
  final AuthController authController;
  final NotificationService _notificationService;

  @observable
  int currentIndex = 0;

  ReactionDisposer? autoRunDisposer;

  Future<void> init() async {
    await authController.init();
    await _notificationService.init();

    autoRunDisposer = autorun((_) {
      if (authController.authState.value == AuthState.loggedIn) {
        tabs = [...tabs, ..._authenticationTabs];
      }
      if (authController.authState.value == AuthState.none) {
        tabs = [..._rawTabs];
      }
    });
  }

  @observable
  List<SidebarItemWithRouter> tabs = [
    SidebarItemWithRouter(
      initialLocation: RouterMeta.fetchEmailAddress.path,
      label: const Text("Get new email address"),
      icon: CupertinoIcons.mail,
    ),
  ];

  final List<SidebarItemWithRouter> _rawTabs = [
    SidebarItemWithRouter(
      initialLocation: RouterMeta.fetchEmailAddress.path,
      label: const Text("Get new email address"),
      icon: CupertinoIcons.mail,
    ),
  ];

  final List<SidebarItemWithRouter> _authenticationTabs = [
    SidebarItemWithRouter(
      initialLocation: RouterMeta.inbox.path,
      label: Text(RouterMeta.inbox.displayTitle),
      icon: CupertinoIcons.tray,
    ),
  ];

  @action
  void onItemTapped(BuildContext context, int tabIndex) {
    currentIndex = tabIndex;
    context.beamToNamed(tabs[tabIndex].initialLocation);
  }

  Future<void> dispose() async {
    autoRunDisposer?.call();
  }
}

void disposeAppViewController(AppViewController instance) {
  instance.dispose();
}
