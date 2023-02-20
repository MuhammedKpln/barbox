import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:spamify/features/app/views/app.view.dart';
import 'package:spamify/features/home/views/home.view.dart';
import 'package:spamify/features/home/views/home.wrapper.dart';
import 'package:spamify/features/mails/views/mail.view.dart';
import 'package:spamify/features/mails/views/mails.view.dart';
import 'package:spamify/features/settings/views/settings.view.dart';
import 'package:spamify/types/messages/message.dart';

enum RouterMeta {
  fetchEmailAddress("/fetch-email-adress", "Fetch new email address"),
  settings("/fetch-email-adress/settings", "Settings"),
  inbox("/inbox", "Inbox"),
  message("/inbox/:msgId", "Message");

  final String path;
  final String displayTitle;
  const RouterMeta(this.path, this.displayTitle);
}

final mainRouterKey = GlobalKey<BeamerState>();

final mainRouterDelegate = BeamerDelegate(
  locationBuilder: BeamerLocationBuilder(
    beamLocations: [
      AppLocation(),
    ],
  ),
);

final appRouterKey = GlobalKey<BeamerState>();
final appRouterDelegate = BeamerDelegate(
  initialPath: RouterMeta.fetchEmailAddress.path,
  locationBuilder: RoutesLocationBuilder(
    routes: {
      RouterMeta.fetchEmailAddress.path: (p0, p1, p2) =>
          const HomeWrapperView(),
      RouterMeta.inbox.path: (p0, p1, p2) => const MailsView(),
    },
  ),
);

final homeRouterKey = GlobalKey<BeamerState>();
final homeRouterDelegate = BeamerDelegate(
    initialPath: RouterMeta.fetchEmailAddress.path,
    locationBuilder: RoutesLocationBuilder(
      routes: {
        RouterMeta.fetchEmailAddress.path: (p0, p1, p2) => const HomeView(),
        RouterMeta.settings.path: (p0, p1, p2) => const SettingsView()
      },
    ));

final mailsRouterKey = GlobalKey<BeamerState>();
final mailsRouterDelegate = BeamerDelegate(
    initialPath: RouterMeta.inbox.path,
    locationBuilder: RoutesLocationBuilder(routes: {
      RouterMeta.inbox.path: (p0, p1, p2) => Container(),
      RouterMeta.message.path: (context, state, data) {
        final msgId = state.pathParameters['msgId']!;
        final message = data as Message;

        return BeamPage(
          key: ValueKey('msg-$msgId'),
          title: message.subject,
          child: MailView(
            msgId: msgId,
          ),
        );
      }
    }));

class AppLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => ['*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    const pages = [
      BeamPage(
        key: ValueKey('app'),
        child: App(),
      ),
    ];

    return pages;
  }
}
