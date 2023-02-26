import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

import 'package:barbox/core/services/di.service.dart';
import 'package:barbox/core/services/router/router.service.dart';
import 'package:barbox/core/storage/isar/base.db.dart';
import 'package:barbox/core/storage/isar/local_account.db.dart';
import 'package:barbox/types/messages/message.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  configureDependencies();
  await initDb([LocalAccountSchema, MessageSchema])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MacosApp.router(
      title: 'BarBox',
      themeMode: ThemeMode.system,
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      routerDelegate: mainRouterDelegate,
      routeInformationParser: BeamerParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}
