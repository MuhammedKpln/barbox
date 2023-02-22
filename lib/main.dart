import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

import 'package:spamify/core/services/di.service.dart';
import 'package:spamify/core/services/router/router.service.dart';
import 'package:spamify/core/storage/isar/base.db.dart';
import 'package:spamify/core/storage/isar/local_account.db.dart';
import 'package:spamify/types/messages/message.dart';

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
      title: 'Spamify',
      themeMode: ThemeMode.system,
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      routerDelegate: mainRouterDelegate,
      routeInformationParser: BeamerParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}
