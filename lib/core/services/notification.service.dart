import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:spamify/core/services/router.service.dart';
import 'package:spamify/types/messages/message.dart' as Model;

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

    await _pl.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {
      final payload = Model.Message.fromJson(details.payload!);

      mailsRouterDelegate.beamToNamed("/inbox/${payload.id}", data: payload);
    });
  }

  Future<void> showNotification(
      {required String title, required String body, String? payload}) async {
    final randomId = Random.secure().nextInt(200);
    const notificationDetails = NotificationDetails();

    await _pl.show(
      randomId,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
