import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/features/app/controller/app.controller.dart';
import 'package:spamify/main.dart';
import 'package:spamify/services/di.service.dart';

class App extends StatefulWidget {
  const App({super.key, required this.child});

  final Widget child;

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
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        body: MacosWindow(
          sidebar: Sidebar(
              minWidth: 210,
              windowBreakpoint: 300,
              isResizable: true,
              bottom: Column(children: [
                // CheckForUpdates(
                //   onPressed: checkForUpdates,
                // ),

                Observer(builder: (_) {
                  if (!controller.hasAlreadyAccount) {
                    return const SizedBox.shrink();
                  }

                  return TextButton(
                      onPressed: () => null, child: const Text("#Qwe"));

                  // return TextButton(
                  //   onPressed: () => Navigator.pushNamed(context, "/settings"),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(20),
                  //     child: Row(children: [
                  //       const MacosIcon(CupertinoIcons.person_circle),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 10),
                  //         child: Text(controller.account?.address ?? "",
                  //             style: MacosTheme.of(context).typography.body),
                  //       )
                  //     ]),
                  //   ),
                  // );
                })
              ]),
              builder: (context, _) {
                return Observer(builder: (_) {
                  return SidebarItems(
                      items: controller.tabs,
                      currentIndex: controller.currentIndex(context),
                      onChanged: (index) =>
                          controller.onItemTapped(context, index));
                });
              }),
          child: widget.child,
        ),
      ),
    );
  }
}
