import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/core/constants/theme.dart';
import 'package:spamify/core/services/di.service.dart';
import 'package:spamify/features/settings/controllers/settings.controller.dart';

class CheckForUpdateSheet extends StatelessWidget {
  const CheckForUpdateSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = getIt<SettingsViewController>();

    return MacosSheet(
        child: Padding(
      padding: EdgeInsets.all(ThemePadding.medium.padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Image.asset(
                "assets/Spamify.png",
                width: 56,
              ),
              Text(
                "Update available!",
                style: MacosTheme.of(context).typography.title3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Observer(builder: (_) {
                return Text(
                  "Version ${controller.update?.version}",
                  style: MacosTheme.of(context).typography.subheadline,
                );
              }),
            ],
          ),
          Observer(builder: (_) {
            if (!controller.updateAvailable.value) {
              return const SizedBox.shrink();
            }

            return Container(
              padding: EdgeInsets.all(ThemePadding.medium.padding),
              constraints: const BoxConstraints(minHeight: 150),
              decoration: BoxDecoration(
                  color: MacosColors.systemGrayColor,
                  borderRadius: BorderRadius.circular(20)),
              child: SelectableText(
                "Changelog:\n\n${controller.update?.changelog ?? "M1 SUPPORTS"}",
                style: MacosTheme.of(context)
                    .typography
                    .body
                    .copyWith(color: MacosColors.white),
              ),
            );
          }),
          PushButton(
            child: const Text("Download"),
            buttonSize: ButtonSize.large,
            onPressed: controller.navigateToDownloads,
          )
        ],
      ),
    ));
  }
}
