import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/features/home/controllers/home.controller.dart';
import 'package:spamify/services/di.service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewController controller = getIt<HomeViewController>();

  @override
  void initState() {
    super.initState();
    controller.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Timer showWelcomeSheet() {
    return Timer(const Duration(milliseconds: 200), () {
      showMacosSheet(
          context: context,
          useRootNavigator: true,
          builder: (_) => _welcomeSheet(_));
    });
  }

  MacosSheet _welcomeSheet(BuildContext _) {
    return MacosSheet(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: Column(
                  children: [
                    Text("Spamify",
                        style: MacosTheme.of(_).typography.largeTitle),
                    Text("Make it simpler & accessible for spam emails",
                        style: MacosTheme.of(_).typography.subheadline),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: const MacosListTile(
                  title: Text("Generate random email adresses"),
                  subtitle: Text("Dispose it in any moment"),
                  leading: MacosIcon(CupertinoIcons.mail_solid),
                ),
              ),
              const MacosListTile(
                title: Text("Use it as primary spam mail address! "),
                subtitle: SizedBox(
                  width: 300,
                  child: Text(
                      "Your mail address will not be disappeared if you choose not to generate new one!"),
                ),
                leading: MacosIcon(CupertinoIcons.tray),
              )
            ],
          ),
          PushButton(
            onPressed: () => Navigator.pop(_),
            child: const Text("Dissmis"),
            buttonSize: ButtonSize.large,
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: _toolBar(),
      children: [
        ContentArea(
          builder: (context) {
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
                              child: MacosTextField(
                                controller: controller.textFieldController,
                                readOnly: true,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
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
      ],
    );
  }

  Observer _copyButton() {
    return Observer(builder: (_) {
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
        ToolBarIconButton(
          label: "",
          showLabel: false,
          icon: const MacosIcon(CupertinoIcons.settings),
          onPressed: () => Navigator.of(context).pushNamed("/settings"),
        ),
      ],
      title: const Text("Fetch new account"),
    );
  }
}
