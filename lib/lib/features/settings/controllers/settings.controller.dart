import 'package:barbox/core/storage/app.storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:barbox/config.dart';
import 'package:barbox/core/auth/controllers/auth.controller.dart';
import 'package:barbox/core/constants/theme.dart';
import 'package:barbox/core/exstensions/toast.extension.dart';
import 'package:barbox/core/services/router/router.service.dart';
import 'package:barbox/core/storage/account.storage.dart';
import 'package:barbox/core/storage/messages.storage.dart';
import 'package:barbox/features/settings/models/update.model.dart';
import 'package:barbox/features/settings/repositories/update.repository.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';

part 'settings.controller.g.dart';

@LazySingleton()
class SettingsViewController = _SettingsViewControllerBase
    with _$SettingsViewController;

abstract class _SettingsViewControllerBase with Store {
  _SettingsViewControllerBase(
      this.accountStorage,
      this.authController,
      this.messagesStorage,
      this._toast,
      this.updateRepository,
      this._appStorage);
  final AccountStorage accountStorage;
  final AuthController authController;
  final MessagesStorage messagesStorage;
  final UpdateRepository updateRepository;
  final AppStorage _appStorage;
  final Toast _toast;

  @observable
  String packageVersion = "";

  @observable
  Observable<bool> updateAvailable = Observable(false);

  @observable
  Updates? update;

  Future<void> initState() async {
    await _getVersion();
    await checkForUpdates();

    authController.authState.observe((value) {
      if (value.newValue != null) {
        if (value.newValue == AuthState.none) {
          appRouterDelegate.beamToNamed(RouterMeta.fetchEmailAddress.path);
        }
      }
    });
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

  @action
  Future<void> checkForUpdates({bool? toggledFromUi}) async {
    final remoteUpdate = await updateRepository.fetchUpdate();

    final remoteVersion = Version.parse(remoteUpdate.version);
    final localVersion = Version.parse(packageVersion);
    final compare = localVersion.compareTo(remoteVersion);

    switch (compare) {
      case -1:
        updateAvailable.value = true;
        update = remoteUpdate;
        print("Update available");
        break;
      case 0:
        if (toggledFromUi != null) {
          _toast.showToast("Update not found.");
        }
        break;
      case 1:
        print("Higher version available");
        break;
    }
  }

  Future<void> navigateToDownloads() async {
    final url = Uri.parse(UPDATE_DOWNLOAD_URL);
    final canOpenUrl = await canLaunchUrl(url);

    if (canOpenUrl) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> clearCache() async {
    final instance = await _appStorage.clearAll();
  }
}
