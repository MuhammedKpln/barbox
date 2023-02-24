import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/core/auth/controllers/auth.controller.dart';
import 'package:spamify/features/home/controllers/home.controller.dart';
import 'package:spamify/core/services/di.service.dart';
import 'package:spamify/features/home/views/components/welcomeSheet.component.dart';

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
    return MacosScaffold(toolBar: _toolBar(), children: [
      ContentArea(
        builder: (context, scrollController) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Hello! ",
                        style: MacosTheme.of(context).typography.largeTitle,
                      ),
                      Text(
                        "Welcome to the email generator, here you can generate a new email address.",
                        style: MacosTheme.of(context).typography.subheadline,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 300,
                            child: Observer(builder: (_) {
                              if (!authController.isLoggedIn) {
                                return const SizedBox.shrink();
                              }

                              return MacosTextField(
                                controller: controller.textFieldController,
                                readOnly: true,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              );
                            }),
                          ),
                          _copyButton()
                        ],
                      ),
                      Observer(builder: (_) {
                        return Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: PushButton(
                            buttonSize: ButtonSize.large,
                            onPressed: () => controller.fetchNewAdress(),
                            child: controller.isLoading
                                ? const ProgressCircle()
                                : const Text("Fetch new account"),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      )
    ]);
  }

  Widget _copyButton() {
    return Observer(builder: (context) {
      if (!authController.isLoggedIn) {
        return const SizedBox.shrink();
      }

      return PushButton(
        buttonSize: ButtonSize.small,
        color: Colors.transparent,
        onPressed: () => controller.copyEmailAddress(),
        child: Observer(builder: (_) {
          return AnimatedCrossFade(
              firstChild: const MacosIcon(CupertinoIcons.doc_on_clipboard),
              secondChild:
                  const MacosIcon(CupertinoIcons.doc_on_clipboard_fill),
              crossFadeState: controller.copied
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 700));
        }),
      );
    });
  }

  ToolBar _toolBar() {
    return ToolBar(
      leading: PushButton(
          buttonSize: ButtonSize.large,
          child: const MacosIcon(CupertinoIcons.line_horizontal_3),
          color: MacosTheme.of(context).pushButtonTheme.disabledColor,
          onPressed: () => MacosWindowScope.of(context).toggleSidebar()),
      actions: [
        CustomToolbarItem(
          inToolbarBuilder: (context) {
            return Observer(
              builder: (context) {
                if (authController.authState.value == AuthState.none) {
                  return const SizedBox.shrink();
                }

                return ToolBarIconButton(
                  label: "",
                  showLabel: false,
                  tooltipMessage: "Settings",
                  icon: const MacosIcon(
                    CupertinoIcons.settings,
                  ),
                  onPressed: () =>
                      context.beamToNamed("/fetch-email-adress/settings"),
                ).build(context, ToolbarItemDisplayMode.inToolbar);
              },
            );
          },
        ),
      ],
      title: const Text("Fetch new account"),
    );
  }
}
