import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/isar/base.db.dart';
import 'package:spamify/isar/local_account.db.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return PushButton(
      child: const Text("logout"),
      buttonSize: ButtonSize.large,
      onPressed: () async {
        isarInstance.writeTxn(() async {
          await isarInstance.localAccounts.clear();
        });
      },
    );
  }
}
