import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:spamify/utils.dart';

import 'cubits/UpdateCubit.dart';

class Updates extends StatefulWidget {
  Updates({Key? key}) : super(key: key);

  @override
  State<Updates> createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  bool updateAvailable = false;
  bool downloading = false;

  @override
  void initState() {
    checkForUpdates();
    super.initState();
  }

  Future<void> checkForUpdates() async {
    await BlocProvider.of<UpdatesCubit>(context).checkForUpdates();
    final state = BlocProvider.of<UpdatesCubit>(context).state;

    if (state is UpdatesLoaded) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      final remoteVersion = Version.parse(state.updates.version);
      final localVersion = Version.parse(packageInfo.version);
      final compare = localVersion.compareTo(remoteVersion);

      switch (compare) {
        case -1:
          setState(() {
            updateAvailable = true;
          });
          print("Update available");
          break;
        case 0:
          print("No update available");
          break;
        case 1:
          print("Higher version available");
          break;
      }
    }
  }

  downloadUpdate(String url) async {
    setState(() {
      downloading = true;
    });
    final downloaded = await downloadFile(url, "Spamify.dmg");

    if (downloaded) {
      showMacosAlertDialog(
          context: context,
          builder: (context) {
            return MacosAlertDialog(
                appIcon: const MacosIcon(CupertinoIcons.checkmark_circle,
                    color: Colors.green),
                title: const Text("Download Successful!"),
                message: const Text(
                    "The update has been downloaded to the folder you selected."),
                primaryButton: PushButton(
                    buttonSize: ButtonSize.large,
                    child: const Text("Ok"),
                    onPressed: () => Navigator.of(context).pop()));
          });
    } else {
      showMacosAlertDialog(
          context: context,
          builder: (context) {
            return MacosAlertDialog(
                appIcon: const MacosIcon(CupertinoIcons.xmark_octagon,
                    color: Colors.red),
                title: const Text("Download interrupted!"),
                message: const Text(
                    "Please select a folder to download new version of Spamify"),
                primaryButton: PushButton(
                    buttonSize: ButtonSize.large,
                    child: const Text("Ok"),
                    onPressed: () => Navigator.of(context).pop()));
          });
    }
    setState(() {
      downloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      titleBar: const TitleBar(
        title: Text("Check for updates"),
      ),
      children: [
        ContentArea(builder: ((context, scrollController) {
          return BlocConsumer<UpdatesCubit, UpdatesState>(
              builder: ((context, state) {
                if (state is UpdatesLoaded) {
                  var updateAvailableWidget = [
                    SvgPicture.asset("assets/Settings.svg",
                        width: 100,
                        color: MacosTheme.of(context).iconTheme.color),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Update available! (v${state.updates.version})",
                        style: TextStyle(
                          fontSize:
                              MacosTheme.of(context).typography.title3.fontSize,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: MacosTheme.of(context).dividerColor),
                      child: Column(
                        children: [
                          MacosListTile(
                            title: const Text("Changelog: "),
                            subtitle: Text(state.updates.changelog),
                            leading: const MacosIcon(CupertinoIcons.down_arrow),
                          ),
                          if (!downloading)
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: PushButton(
                                  onPressed: () =>
                                      downloadUpdate(state.updates.downloadUrl),
                                  child: const Text("Download update"),
                                  buttonSize: ButtonSize.large),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  ProgressCircle(),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text("Downloading..."),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  ];
                  return Center(
                    child: SizedBox(
                      width: 300,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: updateAvailable
                              ? updateAvailableWidget
                              : [
                                  SvgPicture.asset("assets/Settings.svg",
                                      width: 100,
                                      color: MacosTheme.of(context)
                                          .iconTheme
                                          .color),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      "🎉 You're up to date!",
                                      style: TextStyle(
                                        fontSize: MacosTheme.of(context)
                                            .typography
                                            .title3
                                            .fontSize,
                                      ),
                                    ),
                                  ),
                                ]),
                    ),
                  );
                }

                return const Center(
                  child: ProgressCircle(),
                );
              }),
              listener: (context, state) {});
        }))
      ],
    );
  }
}
