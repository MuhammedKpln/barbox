import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import "package:http/http.dart" as http;
import 'package:path_provider/path_provider.dart';

final _random = Random();

String generateRandomString(int len) {
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  return String.fromCharCodes(Iterable.generate(
      len, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

int generateNumber(int min, int max) => min + _random.nextInt(max - min);

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

Future<void> requestNotificationPermission() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true);
  const InitializationSettings initializationSettings =
      InitializationSettings(macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
}

void onSelectNotification(String? payload) {}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) {}

Future<bool> downloadFile(String url, String fileName) async {
  var request = await http.get(Uri.parse(url));

  final result = await FilePicker.platform.saveFile(
    fileName: "Spamify.dmg",
    type: FileType.any,
    dialogTitle: "Where do you want to save new version?",
    allowedExtensions: ["dmg"],
  );

  if (result != null) {
    final file = File(result);
    await file.writeAsBytes(request.bodyBytes);

    return true;
  }

  return false;
}
