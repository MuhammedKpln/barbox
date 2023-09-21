import 'package:barbox/core/services/di.service.dart';
import 'package:barbox/core/services/router/router.service.dart';
import 'package:barbox/features/app/controller/app.controller.dart';
import 'package:barbox/features/app/views/components/new_account.component.dart';
import 'package:barbox/main.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macos_ui/macos_ui.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppViewController controller = getIt<AppViewController>();

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
    return MacosWindow(
      key: mainAppKey,
      sidebar: Sidebar(
          minWidth: 210,
          windowBreakpoint: 300,
          isResizable: true,
          top: renderTop(),
          builder: (context, scrollController) {
            return Observer(builder: (_) {
              return SidebarItems(
                items: controller.tabs,
                currentIndex: controller.currentIndex,
                onChanged: (index) => controller.onItemTapped(context, index),
                scrollController: scrollController,
              );
            });
          }),
      child: Beamer(
        routerDelegate: appRouterDelegate,
        key: appRouterKey,
      ),
    );
  }

  Material renderTop() {
    return Material(
      color: Colors.transparent,
      child: Observer(builder: (_) {
        return ExpansionTile(
          title: Text(
            controller.authController.account.value?.address ?? "",
            style: MacosTheme.of(context).typography.headline,
          ),
          backgroundColor: Colors.transparent,
          trailing: const MacosIcon(
            CupertinoIcons.chevron_down,
            size: 15,
          ),
          leading: const MacosIcon(CupertinoIcons.person_circle, size: 15),
          children: [
            ...controller.availableAccounts ?? [],
            _addNewAccountTile()
          ],
          childrenPadding: const EdgeInsets.all(10),
        );
      }),
    );
  }

  Widget _addNewAccountTile() {
    return MacosListTile(
      title: const Text("Add new account",
          style: TextStyle(fontWeight: FontWeight.normal)),
      leading: const MacosIcon(CupertinoIcons.plus_app_fill),
      mouseCursor: SystemMouseCursors.click,
      onClick: () => showMacosAlertDialog(
        context: context,
        builder: (context) => const NewAccountComponent(),
        barrierDismissible: true,
        useRootNavigator: true,
      ),
    );
  }
}
