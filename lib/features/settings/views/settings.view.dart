import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/core/auth/controllers/auth.controller.dart';
import 'package:spamify/core/theme.dart';
import 'package:spamify/features/settings/controllers/settings.controller.dart';
import 'package:spamify/services/di.service.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final AuthController authController = getIt<AuthController>();
  final SettingsViewController controller = getIt<SettingsViewController>();

  @override
  void initState() {
    super.initState();
    controller.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: const ToolBar(
        title: Text("Settings"),
      ),
      children: [
        ContentArea(
          builder: (context, _) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Observer(builder: (_) {
                    return Column(
                      children: [
                        CircleAvatar(
                          child: Text(
                              authController.account.value?.address?[0] ?? "S"),
                          minRadius: 50,
                          maxRadius: 50,
                        ),
                        Text(authController.account.value?.address ?? "S")
                      ],
                    );
                  }),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PushButton(
                        child: const Text("Logout"),
                        buttonSize: ButtonSize.large,
                        onPressed: controller.logout,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ThemePadding.medium.padding),
                        child: PushButton(
                          child: const Text("Clear all cached mail"),
                          buttonSize: ButtonSize.small,
                          isSecondary: true,
                          onPressed: controller.clearAllCachedMessages,
                        ),
                      ),
                      Observer(builder: (_) {
                        return Text("Version ${controller.packageVersion}",
                            style: MacosTheme.of(context).typography.footnote);
                      })
                    ],
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
