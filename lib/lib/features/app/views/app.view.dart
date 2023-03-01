import 'package:barbox/main.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:barbox/core/auth/controllers/auth.controller.dart';
import 'package:barbox/core/services/router/router.service.dart';
import 'package:barbox/features/app/controller/app.controller.dart';
import 'package:barbox/core/services/di.service.dart';

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
          bottom: _bottomRenderer(),
          builder: (context, _) {
            return Observer(builder: (_) {
              return SidebarItems(
                items: controller.tabs,
                currentIndex: controller.currentIndex,
                onChanged: (index) => controller.onItemTapped(context, index),
              );
            });
          }),
      child: Beamer(
        routerDelegate: appRouterDelegate,
        key: appRouterKey,
      ),
    );
  }

  Widget _bottomRenderer() {
    return Observer(builder: (_) {
      if (controller.authController.authState.value != AuthState.loggedIn) {
        return const SizedBox.shrink();
      }

      return MacosListTile(
        onClick: () {
          context.beamToNamed(
            RouterMeta.fetchEmailAddress.path,
          );
          Future.delayed(
              const Duration(milliseconds: 200),
              () => homeRouterDelegate.beamToNamed(
                    RouterMeta.settings.path,
                  ));
        },
        leading: const Icon(CupertinoIcons.person_circle),
        title: Text(
          controller.authController.account.value?.address ?? "",

          /// Using the MacosTheme to get the typography and then the headline style.
          style: MacosTheme.of(context).typography.headline,
        ),
      );
    });
  }
}
