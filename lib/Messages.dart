import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/Message.dart' as spamify_message;
import 'package:spamify/cubits/MessagesCubit.dart';
import 'package:spamify/types/messages.dart';
import 'package:spamify/utils.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  List<HydraMember>? messages = [];
  int messagesTotalItemCount = 0;
  late Timer _timer;
  bool firstStart = true;

  @override
  initState() {
    requestNotificationPermission();

    super.initState();

    BlocProvider.of<MessagesCubit>(context).stream.listen((event) {
      if (event is MessagesLoaded) {
        if (firstStart) {
          setState(() {
            messages = event.messages.hydraMember;
            messagesTotalItemCount = event.messages.hydraTotalItems;
            firstStart = false;
          });

          return;
        }

        if (event.messages.hydraTotalItems > messagesTotalItemCount) {
          FlutterLocalNotificationsPlugin().show(
              Random().nextInt(9999),
              "Received new email!",
              "You have received a new email!",
              const NotificationDetails(
                macOS: MacOSNotificationDetails(
                  sound: 'default',
                  subtitle: "You have received a new email!",
                ),
              ));
          // New message arrived
          setState(() {
            messages = event.messages.hydraMember;
            messagesTotalItemCount = event.messages.hydraTotalItems;
          });
        }
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchMessages();
    });
  }

  @override
  dispose() {
    super.dispose();
    _timer.cancel();
  }

  Future<void> fetchMessages() async {
    await BlocProvider.of<MessagesCubit>(context).loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return MacosScaffold(
          titleBar: const TitleBar(title: Text("New incoming mails")),
          children: [
            ContentArea(
              builder: (context, scrollController) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 100,
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10, top: 20),
                          child: Column(
                            children: [
                              Center(
                                child: Text("Mails",
                                    textAlign: TextAlign.center,
                                    style: MacosTheme.of(context)
                                        .typography
                                        .largeTitle),
                              ),
                              if (messages!.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("Waiting for new emails",
                                      style: MacosTheme.of(context)
                                          .typography
                                          .title3),
                                )
                            ],
                          )),
                      if (messages!.isNotEmpty)
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: MacosListTile(
                                title: Text(messages?[index].subject ?? ""),
                                subtitle: Text(
                                    "From: ${messages?[index].from?.address}"),
                                onClick: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            spamify_message.Message(
                                              messageId:
                                                  messages?[index].id ?? "",
                                            ))),
                              ),
                            );
                          },
                          itemCount: messages != null ? messages?.length : 0,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                        )
                      else
                        const ProgressCircle()
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
