import 'package:beamer/beamer.dart';
import 'package:barbox/core/auth/controllers/auth.controller.dart';
import 'package:barbox/core/services/di.service.dart';
import 'package:barbox/core/services/router/router.service.dart';

class AuthGuard extends BeamGuard {
  AuthGuard()
      : super(
            pathPatterns: [RouterMeta.settings.path],
            guardNonMatching: false,
            check: (_, __) =>
                getIt<AuthController>().authState.value == AuthState.loggedIn,
            beamToNamed: (_, __) => RouterMeta.fetchEmailAddress.path);
}
