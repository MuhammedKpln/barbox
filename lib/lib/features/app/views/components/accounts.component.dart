import 'package:barbox/core/services/di.service.dart';
import 'package:barbox/features/app/controller/app.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macos_ui/macos_ui.dart';

class AccountsComponent extends StatelessWidget {
  const AccountsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt<AppViewController>();

    return Observer(
      builder: (context) {
        final items = controller.authController.availableAccounts
            .map((e) => MacosPopupMenuItem<String>(
                  value: e.accountId,
                  child: Text(e.accountId),
                  alignment: Alignment.center,
                ))
            .toList();

        return MacosPopupButton<String>(
          items: items,
          onChanged: (value) => controller.authController.switchAccount(value!),
          value: controller.authController.account.value?.accountId,
        );
      },
    );
  }
}
