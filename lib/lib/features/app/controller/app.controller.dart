import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:mobx/mobx.dart';
import 'package:barbox/core/auth/controllers/auth.controller.dart';
import 'package:barbox/core/services/notification.service.dart';
import 'package:barbox/features/app/views/components/sidebarItem.component.dart';
import 'package:barbox/core/services/router/router.service.dart';
import 'package:barbox/core/storage/account.storage.dart';

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

  @computed
  List<MacosListTile>? get availableAccounts {
    return authController.availableAccounts
        ?.where((element) => element.id != authController.account.value?.id)
        .map((e) => MacosListTile(
              title: Text(e.address ?? "s",
                  style: const TextStyle(fontWeight: FontWeight.normal)),
              leading: const MacosIcon(CupertinoIcons.person_circle),
              mouseCursor: SystemMouseCursors.click,
              onClick: () => authController.switchAccount(e.id),
            ))
        .toList();
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
    context.beamToNamed(tabs[tabIndex].initialLocation!);
  }

  Future<void> dispose() async {
    autoRunDisposer?.call();
  }
}

void disposeAppViewController(AppViewController instance) {
  instance.dispose();
}
