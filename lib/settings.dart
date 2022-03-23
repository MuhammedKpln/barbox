import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spamify/storage/account.dart';
import 'package:spamify/storage/messagesStorage.dart';

import 'cubits/AccountCubit.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String packageVersion = "";

  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() => packageVersion = packageInfo.version);
  }

  @override
  void initState() {
    super.initState();
    getVersion();
  }

  void logout() {
    BlocProvider.of<AccountCubit>(context).logout();
    Navigator.of(context).pop();
  }

  void clearData() {
    showMacosAlertDialog(
        context: context,
        builder: (context) {
          return MacosAlertDialog(
            appIcon: const MacosIcon(CupertinoIcons.mail_solid),
            message: const Text(
                "This process will clear all the cached data! You will be logged out. \nAre you sure?"),
            title: const Text("Are you sure you want to clear all data?"),
            horizontalActions: true,
            primaryButton: PushButton(
              child: const Text("Clear"),
              onPressed: () {
                Hive.box(messagesBox).clear();
                Hive.box(accountBox).clear();
                Navigator.of(context).pop();

                showMacosAlertDialog(
                    context: context,
                    builder: (_context) {
                      return MacosAlertDialog(
                          appIcon: const MacosIcon(CupertinoIcons.mail_solid),
                          title: Text("Cleared!"),
                          message: Text("Cache successfully cleared!"),
                          primaryButton: PushButton(
                              buttonSize: ButtonSize.small,
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(_context).pop();
                              }));
                    });
              },
              buttonSize: ButtonSize.small,
            ),
            secondaryButton: PushButton(
              isSecondary: true,
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
              buttonSize: ButtonSize.small,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      titleBar: const TitleBar(
        title: Text("Settings"),
      ),
      children: [
        ContentArea(
          minWidth: double.infinity,
          builder: (context, scrollController) {
            return BlocConsumer<AccountCubit, AccountInitial>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is AccountLoaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          child: Text(state.account.adress
                              .substring(0, 2)
                              .toUpperCase()),
                          minRadius: 50,
                          maxRadius: 50,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: PushButton(
                            child: const Text("Logout"),
                            buttonSize: ButtonSize.large,
                            onPressed: logout,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: PushButton(
                            child: const Text("Clear all data"),
                            buttonSize: ButtonSize.small,
                            isSecondary: true,
                            onPressed: clearData,
                          ),
                        )
                      ],
                    );
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: PushButton(
                          child: const Text("Clear all data"),
                          buttonSize: ButtonSize.small,
                          isSecondary: true,
                          onPressed: clearData,
                        ),
                      ),
                      Text("v$packageVersion")
                    ],
                  );
                });
          },
        )
      ],
    );
  }
}
