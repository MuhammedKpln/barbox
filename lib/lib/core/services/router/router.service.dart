import 'package:barbox/features/home/views/home.view.dart';
import 'package:barbox/features/settings/views/settings.view.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:barbox/core/services/di.service.dart';
import 'package:barbox/core/services/router/router.controller.dart';
import 'package:barbox/features/app/views/app.view.dart';
import 'package:barbox/features/mails/views/mail.view.dart';
import 'package:barbox/features/mails/views/mails.view.dart';
import 'package:barbox/types/messages/message.dart';

enum RouterMeta {
  fetchEmailAddress("/fetch-email-adress", "Fetch new email address"),
  settings("/settings", "Settings"),
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
      RouterMeta.fetchEmailAddress.path: (p0, p1, p2) => const HomeView(),
      RouterMeta.inbox.path: (p0, p1, p2) => const MailsView(),
      RouterMeta.settings.path: (p0, p1, p2) => const SettingsView(),
    },
  ),
);

final mailsRouterKey = GlobalKey<BeamerState>();
final mailsRouterDelegate = BeamerDelegate(
    routeListener: (routeInformation, _) {
      final controller = getIt<RouterServiceController>();

      controller.updateRoute(routeInformation);
    },
    initialPath: RouterMeta.inbox.path,
    transitionDelegate: const NoAnimationTransitionDelegate(),
    locationBuilder: RoutesLocationBuilder(routes: {
      RouterMeta.inbox.path: (p0, p1, p2) =>
          const Center(child: Text("No Message Selected")),
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
        type: BeamPageType.cupertino,
        key: ValueKey('app'),
        child: App(),
      ),
    ];

    return pages;
  }
}
