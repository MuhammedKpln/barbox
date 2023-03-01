import 'package:barbox/config.dart';
import 'package:barbox/core/shared/toast/constants/toastAction.const.dart';
import 'package:barbox/core/shared/toast/constants/toastType.const.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class ToastComponent extends StatelessWidget {
  const ToastComponent({super.key, required this.body, this.type, this.action});

  final String body;
  final ToastType? type;
  final ToastAction? action;

  @override
  Widget build(BuildContext context) {
    void closeDialog() {
      Beamer.of(context).popRoute();
    }

    void onPressed() {
      if (action != null) {
        return action!.onPressed.call();
      }

      return closeDialog();
    }

    Widget renderPrimaryButton() {
      if (action != null) {
        return PushButton(
          child: Text(action!.label),
          buttonSize: ButtonSize.large,
          onPressed: onPressed,
        );
      }

      return PushButton(
        buttonSize: ButtonSize.large,
        child: const Text("Close"),
        onPressed: onPressed,
        isSecondary: true,
      );
    }

    return MacosAlertDialog(
      appIcon: Image.asset(
        "assets/BarBox.png",
        width: 56,
        height: 56,
      ),
      title: Text(
        APP_NAME,
        style: MacosTheme.of(context).typography.headline,
      ),
      message: Text(
        body,
        textAlign: TextAlign.center,
        style: MacosTheme.of(context).typography.headline,
      ),
      primaryButton: renderPrimaryButton(),
      secondaryButton: action != null
          ? PushButton(
              buttonSize: ButtonSize.large,
              child: const Text("Close"),
              onPressed: closeDialog,
              isSecondary: true,
            )
          : null,
    );
  }
}
