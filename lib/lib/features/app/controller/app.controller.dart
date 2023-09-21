import 'dart:async';

import 'package:barbox/core/auth/controllers/auth.controller.dart';
import 'package:barbox/core/services/notification.service.dart';
import 'package:barbox/core/services/router/router.service.dart';
import 'package:barbox/core/shared/toast/views/controllers/toast.controller.dart';
import 'package:barbox/core/storage/account.storage.dart';
import 'package:barbox/features/app/views/components/sidebarItem.component.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:mobx/mobx.dart';

part 'app.controller.g.dart';

@LazySingleton()
class AppViewController = _AppViewControllerBase with _$AppViewController;

abstract class _AppViewControllerBase with Store {
  _AppViewControllerBase(this.accountStorage, this.authController,
      this._notificationService, this._toast);

  final AccountStorage accountStorage;
  final AuthController authController;
  final NotificationService _notificationService;
  final Toast _toast;

  @observable
  int currentIndex = 0;

  ReactionDisposer? autoRunDisposer;

  Future<void> init() async {
    await authController.init();
    await _notificationService.init();

    authController.availableAccounts.observe((value) async {
      if (value.list.isEmpty) {
        await authController.registerWithRandomUsername();
        _toast.showToast(
            "You've logged out from all accounts, generating random account.");
      }
    });

    autoRunDisposer = autorun((_) {
      if (authController.authState.value == AuthState.loggedIn) {
        tabs = [..._authenticationTabs, ...tabs];
      }
      if (authController.authState.value == AuthState.none) {
        tabs = [..._rawTabs];
      }
    });
  }

  @computed
  List<MacosListTile>? get availableAccounts {
    return authController.availableAccounts
        .where((element) => element.id != authController.account.value?.id)
        .map((e) => MacosListTile(
              title: Text(e.address,
                  style: const TextStyle(fontWeight: FontWeight.normal)),
              leading: const MacosIcon(CupertinoIcons.person_circle),
              mouseCursor: SystemMouseCursors.click,
              onClick: () => authController.switchAccount(e.accountId),
            ))
        .toList();
  }

  @observable
  List<SidebarItemWithRouter> tabs = [];

  final List<SidebarItemWithRouter> _rawTabs = [];

  final List<SidebarItemWithRouter> _authenticationTabs = [
    SidebarItemWithRouter(
      initialLocation: RouterMeta.inbox.path,
      label: Text(RouterMeta.inbox.displayTitle),
      icon: CupertinoIcons.tray,
    ),
    SidebarItemWithRouter(
      initialLocation: RouterMeta.settings.path,
      label: const Text("Settings"),
      icon: CupertinoIcons.settings,
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
