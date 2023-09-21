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

    PushButton renderPrimaryButton() {
      if (action != null) {
        return PushButton(
          child: Text(action!.label),
          controlSize: ControlSize.large,
          onPressed: onPressed,
        );
      }

      return PushButton(
        controlSize: ControlSize.large,
        child: const Text("Close"),
        secondary: true,
        onPressed: onPressed,
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
              controlSize: ControlSize.large,
              child: const Text("Close"),
              onPressed: closeDialog,
              secondary: true,
            )
          : null,
    );
  }
}
