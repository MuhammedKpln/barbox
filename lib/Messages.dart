import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/Message.dart' as spamify_message;
import 'package:spamify/cubits/MessagesCubit.dart';
import 'package:spamify/storage/messagesStorage.dart';
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
  String? messageId;
  late Timer _timer;
  bool firstStart = true;

  @override
  initState() {
    super.initState();
    requestNotificationPermission();

    Timer(const Duration(milliseconds: 200), () {
      MacosWindowScope.of(context).toggleSidebar();
    });

    BlocProvider.of<MessagesCubit>(context).stream.listen((event) {
      if (event is MessagesLoaded) {
        if (getCachedMessages() == null && event.messages.hydraTotalItems > 0) {
          storeMessages(event.messages);
        }

        if (firstStart) {
          setState(() {
            messages = event.messages.hydraMember;
            messagesTotalItemCount = event.messages.hydraTotalItems;
            firstStart = false;
          });

          return;
        }

        if (event.messages.hydraMember!.isNotEmpty && messages!.isNotEmpty) {
          if (messages!.length >= 1) {
            final MessagesModel messagesFromCache = getCachedMessages();
            if (event.messages.hydraMember?.first.id !=
                messagesFromCache.hydraMember?.last.id) {
              addNewMessage(event.messages.hydraMember!.first);
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
              setState(() {
                messages = event.messages.hydraMember;
                messagesTotalItemCount = event.messages.hydraTotalItems;
              });
            }
          }
        }
      }
    });

    BlocProvider.of<MessagesCubit>(context).loadFromCache();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchMessages();
    });
  }

  @override
  dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchMessages() async {
    await BlocProvider.of<MessagesCubit>(context).loadMessages();
  }

  Future<void> deleteMail(String messageId, int index) async {
    await BlocProvider.of<MessagesCubit>(context).deleteMessage(messageId);
    setState(() {
      messages?.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return MacosScaffold(
          titleBar: TitleBar(
            leading: GestureDetector(
              onTap: () {
                MacosWindowScope.of(context).toggleSidebar();
              },
              child: const MacosIcon(CupertinoIcons.line_horizontal_3),
            ),
            title: const Text("Inbox"),
          ),
          children: [
            ResizablePane(
              startWidth: 250,
              minWidth: 150,
              resizableSide: ResizableSide.right,
              isResizable: true,
              builder: (context, scrollController) {
                if (messages!.isNotEmpty) {
                  return MessagesList(
                    messages: messages,
                    messageId: messageId,
                    onTap: (_messageId, index) {
                      if (messageId == index) {
                        setState(() => messageId = null);
                        return;
                      }

                      setState((() {
                        messageId = _messageId;
                        messages?[index].seen = true;
                      }));
                    },
                  );
                } else {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      ProgressCircle(),
                      Text("Fetching inbox...")
                    ],
                  ));
                }
              },
            ),
            ContentArea(builder: (context, scrollController) {
              if (messageId != null) {
                return spamify_message.Message(messageId: messageId ?? "");
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/Mailbox.svg",
                      width: 100,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("No message selected"),
                    )
                  ],
                ),
              );
            })
          ],
        );
      },
    );
  }
}

class MessagesList extends StatelessWidget {
  const MessagesList(
      {Key? key,
      required this.messages,
      required this.messageId,
      required this.onTap})
      : super(key: key);

  final List<HydraMember>? messages;
  final String? messageId;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.separated(
          itemBuilder: ((context, index) {
            final message = messages?[index];

            if (message == null) {
              return Container();
            }

            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  onTap(message.id, index);
                  // setState(() {
                  //   messageId = message.id;
                  // });
                },
                child: Container(
                  padding: messageId == message.id
                      ? const EdgeInsets.all(5)
                      : const EdgeInsets.only(left: 5),
                  decoration: messageId == message.id
                      ? const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.2))
                      : null,
                  child: Row(
                    children: [
                      if (!message.seen)
                        Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade600,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(children: [
                            CircleAvatar(
                              child: Text(
                                  message.from?.name?.substring(0, 1) ?? "U"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        message.from?.name ?? "Unknown sender"),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                          message.subject ?? "No subject",
                                          overflow: TextOverflow.clip),
                                    ),
                                  ]),
                            )
                          ]),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10),
                            child: SizedBox(
                                width: 200,
                                child: Text(message.intro ?? "No intro")),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          separatorBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
              ),
          itemCount: messages!.length),
    );
  }
}
