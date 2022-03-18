import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/Home.dart';
import 'package:spamify/Messages.dart';
import 'package:spamify/cubits/AccountCubit.dart';
import 'package:spamify/cubits/MessageCubit.dart';
import 'package:spamify/cubits/repositories/AccountsRespository.dart';
import 'package:spamify/cubits/repositories/MessageRepository.dart';
import 'package:spamify/utils.dart';

import 'cubits/MessagesCubit.dart';
import 'cubits/repositories/MessagesRepository.dart';

void main() {
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
            lazy: false,
            create: (context) => MessageCubit(
                BlocProvider.of<AccountCubit>(context), MessageRepo()),
          ),
          BlocProvider(
            create: (context) => MessagesCubit(
                MessagesRepo(), BlocProvider.of<AccountCubit>(context)),
          )
        ],
        child: MacosApp(
          title: 'Spamify',
          theme: MacosThemeData.light(),
          home: const MyHomePage(title: 'Spamify'),
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
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return BlocConsumer<AccountCubit, AccountInitial>(
      listener: (context, state) {},
      builder: (_context, state) {
        return MacosWindow(
          sidebar: Sidebar(
              minWidth: 250,
              windowBreakpoint: 300,
              isResizable: true,
              bottom: const MacosTooltip(
                message: 'Logout',
                child: Account(),
              ),
              builder: (context, controller) {
                return SidebarItems(
                    currentIndex: pageIndex,
                    onChanged: (i) => setState(() => pageIndex = i),
                    items: [
                      const SidebarItem(
                          label: Text("Get new email address"),
                          leading: MacosIcon(
                            CupertinoIcons.mail,
                            size: 15,
                          )),
                      if (state is AccountLoaded)
                        const SidebarItem(
                            label: Text("Inbox"),
                            leading: MacosIcon(
                              CupertinoIcons.tray_full_fill,
                              size: 15,
                            ))
                    ]);
              }),
          child: Window(pageIndex: pageIndex),
        );
      },
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
    logout() {
      BlocProvider.of<AccountCubit>(context).logout();
    }

    return BlocConsumer<AccountCubit, AccountInitial>(
        builder: ((context, state) {
          if (state is AccountLoaded) {
            return TextButton(
              onPressed: logout,
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
