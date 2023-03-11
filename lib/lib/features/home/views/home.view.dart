import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:barbox/core/auth/controllers/auth.controller.dart';
import 'package:barbox/features/home/controllers/home.controller.dart';
import 'package:barbox/core/services/di.service.dart';
import 'package:barbox/features/home/views/components/welcomeSheet.component.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewController controller = getIt<HomeViewController>();
  final AuthController authController = getIt<AuthController>();

  @override
  void initState() {
    super.initState();
    controller.initState();

    controller.shouldShowWelcomeSheet.observe((value) {
      if (value.newValue != null) {
        if (value.newValue == true) {
          showWelcomeSheet();

          return;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> showWelcomeSheet() async {
    await showMacosSheet(
        context: context, builder: (_) => const HomeWelcomeSheet());
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(children: [
      ContentArea(
        builder: (context, scrollController) {
          return const Center(
              child: ProgressCircle(
            value: null,
          ));
        },
      )
    ]);
  }
}
