import 'package:barbox/core/constants/theme.dart';
import 'package:barbox/core/services/di.service.dart';
import 'package:barbox/features/app/controller/new_account.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macos_ui/macos_ui.dart';

class NewAccountComponent extends StatefulWidget {
  const NewAccountComponent({super.key});

  @override
  State<NewAccountComponent> createState() => _NewAccounSheettComponentState();
}

class _NewAccounSheettComponentState extends State<NewAccountComponent> {
  final controller = getIt<NewAccountController>();

  @override
  void initState() {
    super.initState();

    controller.init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MacosAlertDialog(
      horizontalActions: true,
      appIcon: const MacosIcon(
        CupertinoIcons.person_add,
        size: 30,
      ),
      title: Text(
        "Create new address",
        style: MacosTheme.of(context).typography.headline,
      ),
      message: Column(
        children: [
          FocusTraversalGroup(
              policy: WidgetOrderTraversalPolicy(),
              child: Column(
                children: [
                  MacosTextField(
                    placeholder: "Username",
                    suffix: _usernameSuffix(),
                    controller: controller.controllerUsername,
                    onChanged: controller.updateUsername,
                  ),
                  Observer(builder: (_) {
                    return MacosTextField(
                      placeholder: "Password",
                      suffix: _passwordSuffix(),
                      controller: controller.controllerPassword,
                      obscureText: controller.obsecuredText,
                      onChanged: controller.updatePassword,
                    );
                  })
                ],
              ))
        ],
      ),
      secondaryButton: PushButton(
        child: const Text("Cancel"),
        isSecondary: true,
        buttonSize: ButtonSize.large,
        onPressed: () => Navigator.of(context).pop(),
      ),
      primaryButton: Observer(
        builder: (context) => PushButton(
          child: const Text("Create"),
          buttonSize: ButtonSize.large,
          onPressed: controller.isFormValid
              ? () => controller.createAddress(context)
              : null,
        ),
      ),
    );
  }

  Widget _passwordSuffix() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: controller.generateRandomPassword,
              child: const MacosIcon(CupertinoIcons.shuffle, size: 15)),
        ),
        Padding(
          padding: EdgeInsets.only(left: ThemePadding.small.padding),
          child: Observer(builder: (_) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                  onTap: controller.toggleObsecureText,
                  child: MacosIcon(
                      controller.obsecuredText
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                      size: 15)),
            );
          }),
        )
      ],
    );
  }

  Widget _usernameSuffix() {
    return Observer(
      builder: (context) {
        final items = controller.domains.value?.hydraMember
            .map((e) => MacosPopupMenuItem<String>(
                  child: Text(e.domain),
                  value: e.domain,
                ))
            .toList();

        return MacosPopupButton<String>(
          items: items,
          onChanged: controller.updateDomain,
          value: controller.selectedDomain,
        );
      },
    );
  }
}
