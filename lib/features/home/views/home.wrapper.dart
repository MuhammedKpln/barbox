import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/core/services/router/router.service.dart';

class HomeWrapperView extends StatelessWidget {
  const HomeWrapperView({super.key});

  toolbar(BuildContext context) {
    return ToolBar(
      leading: PushButton(
          buttonSize: ButtonSize.large,
          child: const MacosIcon(CupertinoIcons.line_horizontal_3),
          color: MacosTheme.of(context).pushButtonTheme.disabledColor,
          onPressed: () => MacosWindowScope.of(context).toggleSidebar()),
      actions: [
        ToolBarIconButton(
          label: "",
          showLabel: false,
          icon: const MacosIcon(CupertinoIcons.settings),
          onPressed: () => homeRouterDelegate.beamToNamed(
            RouterMeta.settings.path,
            stacked: true,
            replaceRouteInformation: true,
          ),
        ),
      ],
      title: const Text("Fetch new account"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Beamer(routerDelegate: homeRouterDelegate, key: homeRouterKey);
  }
}
