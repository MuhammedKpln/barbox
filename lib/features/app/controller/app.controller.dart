import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:spamify/core/auth/controllers/auth.controller.dart';
import 'package:spamify/features/app/views/components/sidebarItem.component.dart';
import 'package:spamify/services/router.service.dart';
import 'package:spamify/storage/account.storage.dart';

part 'app.controller.g.dart';

@LazySingleton()
class AppViewController = _AppViewControllerBase with _$AppViewController;

abstract class _AppViewControllerBase with Store {
  _AppViewControllerBase(this.accountStorage, this.authController);

  final AccountStorage accountStorage;
  final AuthController authController;

  ReactionDisposer? autoRunDisposer;

  Future<void> init() async {
    await authController.init();

    autoRunDisposer = autorun((_) {
      if (authController.authState.value == AuthState.loggedIn) {
        tabs = [...tabs, ..._authenticationTabs];
      }
    });
  }

  @observable
  List<SidebarItemWithRouter> tabs = [
    SidebarItemWithRouter(
        initialLocation: RouterMeta.fetchEmailAddress.toString(),
        label: const Text("Get new email address"),
        icon: CupertinoIcons.mail),
  ];

  final List<SidebarItemWithRouter> _authenticationTabs = [
    SidebarItemWithRouter(
      initialLocation: RouterMeta.inbox.toString(),
      label: Text(RouterMeta.inbox.displayTitle),
      icon: CupertinoIcons.tray,
    ),
  ];

  int _locationToTabIndex(String location) {
    final index =
        tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  int currentIndex(BuildContext context) =>
      _locationToTabIndex(GoRouter.of(context).location);

  // callback used to navigate to the desired tab
  void onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != currentIndex) {
      // go to the initial location of the selected tab (by index)
      context.go(tabs[tabIndex].initialLocation);
    }
  }

  Future<void> dispose() async {
    autoRunDisposer?.call();
  }
}

void disposeAppViewController(AppViewController instance) {
  instance.dispose();
}
