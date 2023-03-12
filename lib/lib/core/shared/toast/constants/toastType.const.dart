import 'dart:ui';

import 'package:macos_ui/macos_ui.dart';

/// Toast types
enum ToastType {
  error(MacosColors.appleRed),
  success(MacosColors.systemGreenColor),
  info(MacosColors.black);

  final Color color;
  const ToastType(this.color);
}
