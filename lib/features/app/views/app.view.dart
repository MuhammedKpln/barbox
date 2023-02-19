import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/core/auth/controllers/auth.controller.dart';
import 'package:spamify/core/services/router.service.dart';
import 'package:spamify/features/app/controller/app.controller.dart';
import 'package:spamify/main.dart';
import 'package:spamify/core/services/di.service.dart';

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
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: MacosScaffold(
        children: [
          ContentArea(
            builder: (context, scrollController) {
              return MacosWindow(
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
                          onChanged: (index) =>
                              controller.onItemTapped(context, index),
                        );
                      });
                    }),
                child: Beamer(
                  routerDelegate: appRouterDelegate,
                  key: appRouterKey,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Column _bottomRenderer() {
    return Column(children: [
      // CheckForUpdates(
      //   onPressed: checkForUpdates,
      // ),

      Observer(builder: (_) {
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
            style: MacosTheme.of(context).typography.headline,
          ),
        );
      })
    ]);
  }
}
