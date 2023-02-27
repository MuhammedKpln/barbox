import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class SidebarItemWithRouter extends SidebarItem {
  SidebarItemWithRouter(
      {required Widget label,
      required this.initialLocation,
      required IconData icon})
      : super(
            label: label,
            leading: Icon(
              icon,
              size: 14,
            ));

  final String initialLocation;
}
