import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:barbox/core/services/di.service.dart';
import 'package:barbox/features/home/controllers/home.controller.dart';

class HomeWelcomeSheet extends StatelessWidget {
  const HomeWelcomeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt<HomeViewController>();

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
                    Text("BarBox",
                        style: MacosTheme.of(context).typography.largeTitle),
                    Text("Make it simpler & accessible for spam emails",
                        style: MacosTheme.of(context).typography.subheadline),
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
            onPressed: () => controller.closeHomeSheet(context),
            child: const Text("Dismiss"),
            buttonSize: ButtonSize.large,
          )
        ],
      ),
    ));
  }
}
