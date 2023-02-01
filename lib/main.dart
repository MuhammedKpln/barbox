import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/Home.dart';
import 'package:spamify/Messages.dart';
import 'package:spamify/Updates.dart';
import 'package:spamify/cubits/AccountCubit.dart';
import 'package:spamify/cubits/MessageCubit.dart';
import 'package:spamify/cubits/UpdateCubit.dart';
import 'package:spamify/cubits/repositories/AccountsRespository.dart';
import 'package:spamify/cubits/repositories/MessageRepository.dart';
import 'package:spamify/cubits/repositories/UpdatesRepository.dart';
import 'package:spamify/services/di.service.dart';
import 'package:spamify/settings.dart';
import 'package:spamify/storage/account.dart';
import 'package:spamify/storage/messagesStorage.dart';
import 'package:spamify/utils.dart';

import 'cubits/MessagesCubit.dart';
import 'cubits/repositories/MessagesRepository.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(accountBox);
  await Hive.openBox(messagesBox);
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AccountCubit>(
            lazy: false,
            create: (context) => AccountCubit(AccountRepo()),
          ),
          BlocProvider<MessageCubit>(
            create: (context) => MessageCubit(
                BlocProvider.of<AccountCubit>(context), MessageRepo()),
          ),
          BlocProvider(
            create: (context) => MessagesCubit(
                MessagesRepo(), BlocProvider.of<AccountCubit>(context)),
          ),
          BlocProvider(create: (context) => UpdatesCubit(UpdatesRepo()))
        ],
        child: MacosApp(
          title: 'Spamify',
          theme: MacosThemeData.light(),
          initialRoute: '/',
          routes: {
            '/': (context) => const MyHomePage(title: "Spamify"),
            '/settings': (context) => const Settings(),
            '/updates': (context) => Updates(),
          },
          scrollBehavior: MyCustomScrollBehavior(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AccountCubit>(context).loadAccount();
    // Hive.box(accountBox).clear();
    // Hive.box(messagesBox).clear();
    // print(Hive.box(messagesBox).values);

    // BlocProvider.of<AccountCubit>(context).stream.listen((state) {
    //   if (state is AccountLoaded) {
    //     setState(() {
    //       loggedIn = true;
    //       loaded = true;
    //     });
    //   } else if (state is! AccountLoaded) {
    //     setState(() {
    //       loggedIn = false;
    //       loaded = false;
    //     });

    //     Timer(const Duration(milliseconds: 200), () {
    //       setState(() {
    //         loaded = true;
    //       });
    //     });
    //   }
    // });
  }

  void checkForUpdates() async {
    Navigator.of(context).pushNamed("/updates");
  }

  @override
  Widget build(BuildContext context) {
    // if (!loaded) {
    //   return const Center(
    //     child: ProgressCircle(),
    //   );
    // }

    return MacosWindow(
      sidebar: Sidebar(
          minWidth: 250,
          windowBreakpoint: 300,
          isResizable: true,
          bottom: Column(children: [
            CheckForUpdates(
              onPressed: checkForUpdates,
            ),
            const Account()
          ]),
          builder: (context, controller) {
            return BlocConsumer<AccountCubit, AccountInitial>(
                builder: (context, state) {
                  if (state is! AccountLoaded) {
                    return SidebarItems(
                        currentIndex: pageIndex,
                        onChanged: (i) => setState(() => pageIndex = i),
                        items: const [
                          SidebarItem(
                              label: Text("Get new email address"),
                              leading: MacosIcon(
                                CupertinoIcons.mail,
                                size: 15,
                              )),
                        ]);
                  }

                  if (state is AccountLoaded) {
                    return SidebarItems(
                        currentIndex: pageIndex,
                        onChanged: (i) => setState(() => pageIndex = i),
                        items: const [
                          SidebarItem(
                              label: Text("Get new email address"),
                              leading: MacosIcon(
                                CupertinoIcons.mail,
                                size: 15,
                              )),
                          SidebarItem(
                              label: Text("Inbox"),
                              leading: MacosIcon(
                                CupertinoIcons.tray_full_fill,
                                size: 15,
                              ))
                        ]);
                  }

                  return const Center(
                    child: ProgressCircle(),
                  );
                },
                listener: (context, s) => {});
          }),
      child: Window(pageIndex: pageIndex),
    );
  }
}

class CheckForUpdates extends StatelessWidget {
  const CheckForUpdates({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(children: [
          const MacosIcon(CupertinoIcons.arrow_counterclockwise),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("Check for updates",
                style: MacosTheme.of(context).typography.body),
          )
        ]),
      ),
    );
  }
}

class Window extends StatelessWidget {
  const Window({
    Key? key,
    required this.pageIndex,
  }) : super(key: key);

  final int pageIndex;

  List<Widget> buildChildren() {
    final children = <Widget>[
      const Home(),
    ];

    switch (pageIndex) {
      case 0:
        return children;
      case 1:
        children.add(const Messages());
        return children;

      default:
        return children;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(index: pageIndex, children: buildChildren());
  }
}

class Account extends StatelessWidget {
  const Account({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountInitial>(
        builder: ((context, state) {
          if (state is AccountLoaded) {
            return TextButton(
              onPressed: () => Navigator.pushNamed(context, "/settings"),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(children: [
                  const MacosIcon(CupertinoIcons.person_circle),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(state.account.adress,
                        style: MacosTheme.of(context).typography.body),
                  )
                ]),
              ),
            );
          }

          return Container();
        }),
        listener: (context, state) {});
  }
}
