import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class SidebarItemWithRouter extends SidebarItem {
  SidebarItemWithRouter(
      {required Widget label,
      this.initialLocation,
      IconData? icon,
      List<SidebarItemWithRouter>? disclosureItems})
      : super(
          label: label,
          leading: icon != null
              ? Icon(
                  icon,
                  size: 14,
                )
              : null,
          disclosureItems: disclosureItems,
        );

  final String? initialLocation;
}
