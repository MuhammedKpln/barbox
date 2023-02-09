import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/features/app/views/app.view.dart';
import 'package:spamify/features/home/views/home.view.dart';
import 'package:spamify/features/mails/views/mails.view.dart';
import 'package:spamify/features/settings/views/settings.view.dart';

enum RouterMeta {
  fetchEmailAddress("fetch-email-adress", "Fetch new email address"),
  settings("settings", "Settings"),
  inbox("inbox", "Inbox");

  final String path;
  final String displayTitle;
  const RouterMeta(this.path, this.displayTitle);

  @override
  String toString() => "/$path";
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouterMeta.fetchEmailAddress.toString(),
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      routes: [
        GoRoute(
          path: RouterMeta.fetchEmailAddress.toString(),
          builder: (context, state) => const HomeView(),
        ),
        GoRoute(
          path: '/inbox',
          builder: (context, state) => const MailsView(),
        ),
        GoRoute(
          path: RouterMeta.settings.toString(),
          builder: (context, state) => MacosScaffold(children: [
            ContentArea(
              builder: (context) {
                return const SettingsView();
              },
            )
          ]),
        ),
      ],
      builder: (context, state, child) {
        return App(child: child);
      },
    )
  ],
);
