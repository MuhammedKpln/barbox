import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spamify/core/auth/controllers/auth.controller.dart';
import 'package:spamify/core/exstensions/toast.extension.dart';
import 'package:spamify/core/theme.dart';
import 'package:spamify/storage/account.storage.dart';
import 'package:spamify/storage/messages.storage.dart';
part 'settings.controller.g.dart';

@LazySingleton()
class SettingsViewController = _SettingsViewControllerBase
    with _$SettingsViewController;

abstract class _SettingsViewControllerBase with Store {
  _SettingsViewControllerBase(this.accountStorage, this.authController,
      this.messagesStorage, this._toast);
  final AccountStorage accountStorage;
  final AuthController authController;
  final MessagesStorage messagesStorage;
  final Toast _toast;

  @observable
  String packageVersion = "";

  Future<void> initState() async {
    await _getVersion();
  }

  Future<void> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageVersion = packageInfo.version;
  }

  Future<void> logout() async {
    await authController.logout();
  }

  Future<void> clearAllCachedMessages() async {
    Future<void> clear() async {
      await messagesStorage.clear();

      _toast.showToast(
        "Done.",
        toastType: ToastType.success,
      );
    }

    _toast.showToast(
      "You are deleting all cached mails, are you sure?",
      action: SnackBarAction(label: "Delete all", onPressed: clear),
    );
  }
}
