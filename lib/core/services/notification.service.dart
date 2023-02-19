import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class NotificationService {
  final _pl = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const initDarwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(macOS: initDarwin);

    await _pl.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print("received rrr");
        print(details);
        // rootNavigatorKey.currentContext?.go("/inbox/message");
      },
      onDidReceiveBackgroundNotificationResponse: (details) {
        print("received");
        print(details);
      },
    );
  }

  Future<void> showNotification(
      {required String title, required String body}) async {
    final randomId = Random.secure().nextInt(200);
    const notificationDetails = NotificationDetails();

    await _pl.show(randomId, title, body, notificationDetails);
  }
}
