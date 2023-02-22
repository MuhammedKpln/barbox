import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

enum ThemePadding {
  small(10),
  medium(15),
  large(20);

  final double padding;
  const ThemePadding(this.padding);
}

/// Toast types
enum ToastType {
  error(MacosColors.appleRed),
  success(MacosColors.systemGreenColor),
  info(MacosColors.black);

  final Color color;
  const ToastType(this.color);
}
