import 'dart:async';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/cubits/AccountCubit.dart';
import 'package:spamify/storage/account.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAccount().then((account) {
      if (account is Account) {
        BlocProvider.of<AccountCubit>(context)
            .login(account.adress, account.password);
      } else {
        showWelcomeSheet();
      }
    });
  }

  Timer showWelcomeSheet() {
    return Timer(const Duration(milliseconds: 200), () {
      showMacosSheet(
          context: context,
          useRootNavigator: true,
          builder: (_) => MacosSheet(
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
                                  style:
                                      MacosTheme.of(_).typography.largeTitle),
                              Text(
                                  "Make it simpler & accessible for spam emails",
                                  style:
                                      MacosTheme.of(_).typography.subheadline),
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
              )));
    });
  }

  Future<void> fetchNewEmailAdress() async {
    await BlocProvider.of<AccountCubit>(context).fetchNewAdress();
  }

  void copyEmailAddress() {
    final account =
        (BlocProvider.of<AccountCubit>(context).state) as AccountLoaded;
    FlutterClipboard.copy(account.account.adress);

    showMacosAlertDialog(
        context: context,
        builder: (_) => MacosAlertDialog(
              title: const Text("Copied!"),
              message: const Text(
                  "Your email address has been copied to clipboard!"),
              appIcon: const MacosIcon(CupertinoIcons.mail_solid),
              primaryButton: PushButton(
                onPressed: () => Navigator.pop(_),
                child: const Text("Dissmis"),
                buttonSize: ButtonSize.large,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountInitial>(
      listener: (context, state) {
        if (state is AccountLoaded) {
          textFieldController.text = state.account.adress;
        }
        if (state is! AccountLoaded) {
          textFieldController.text = "";
        }

        if (state is AccountError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Try again"),
          ));
        }
      },
      builder: (context, state) {
        return MacosScaffold(
          titleBar: TitleBar(
            leading: GestureDetector(
              onTap: () {
                MacosWindowScope.of(context).toggleSidebar();
              },
              child: const MacosIcon(CupertinoIcons.line_horizontal_3),
            ),
            title: const Text("Fetch new account"),
          ),
          children: [
            ContentArea(
              builder: (context, scrollController) => Center(
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
                            style:
                                MacosTheme.of(context).typography.subheadline,
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
                                  controller: textFieldController,
                                  readOnly: true,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  toolbarOptions:
                                      const ToolbarOptions(copy: true),
                                ),
                              ),
                              if (state is AccountLoaded)
                                PushButton(
                                    buttonSize: ButtonSize.small,
                                    color: Colors.transparent,
                                    onPressed: () => copyEmailAddress(),
                                    child: const MacosIcon(
                                      CupertinoIcons.doc_on_doc,
                                      size: 20,
                                    ))
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: PushButton(
                              buttonSize: ButtonSize.large,
                              onPressed: () => fetchNewEmailAdress(),
                              child: state is AccountLoading
                                  ? state is AccountError
                                      ? const Text("Try again")
                                      : const ProgressCircle()
                                  : const Text("Fetch new account"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
