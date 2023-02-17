import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spamify/features/app/views/app.view.dart';
import 'package:spamify/features/home/views/home.view.dart';
import 'package:spamify/features/mails/views/mail.view.dart';
import 'package:spamify/features/mails/views/mails.view.dart';
import 'package:spamify/features/settings/views/settings.view.dart';

enum RouterMeta {
  fetchEmailAddress("fetch-email-adress", "Fetch new email address"),
  settings("settings", "Settings"),
  inbox("inbox", "Inbox"),
  message("message/:msgId", "Message");

  final String path;
  final String displayTitle;
  const RouterMeta(this.path, this.displayTitle);

  @override
  String toString() => "/$path";
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKeym =
    GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: RouterMeta.fetchEmailAddress.toString(),
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      routes: [
        GoRoute(
          path: RouterMeta.fetchEmailAddress.toString(),
          builder: (context, state) => const HomeView(),
        ),
        ShellRoute(
          navigatorKey: shellNavigatorKeym,
          routes: [
            GoRoute(
                path: RouterMeta.inbox.toString(),
                builder: (context, state) => MailsView(
                      child: Container(),
                    ),
                routes: [
                  GoRoute(
                    path: RouterMeta.message.path,
                    name: RouterMeta.message.name,
                    builder: (context, state) {
                      final msgId = state.params["msgId"];

                      return MailView(
                        msgId: msgId!,
                      );
                    },
                  )
                ]),
          ],
          builder: (context, state, child) => MailsView(
            child: child,
          ),
        ),
        GoRoute(
          path: RouterMeta.settings.toString(),
          builder: (context, state) => const SettingsView(),
        ),
      ],
      builder: (context, state, child) {
        return App(child: child);
      },
    )
  ],
);
