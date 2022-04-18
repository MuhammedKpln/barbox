import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:native_context_menu/native_context_menu.dart'
    as NativeContextMenu;
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
  bool refetching = false;

  @override
  initState() {
    super.initState();
    requestNotificationPermission();

    Timer(const Duration(milliseconds: 200), () {
      MacosWindowScope.of(context).toggleSidebar();
    });

    BlocProvider.of<MessagesCubit>(context).stream.listen((event) {
      if (event is MessagesLoaded) {
        final MessagesModel messagesFromCache = getCachedMessages();

        if (messagesFromCache.hydraTotalItems < 1 &&
            event.messages.hydraTotalItems > 0) {
          // Check for cached messages, if none, then store them
          storeMessages(event.messages);
        }

        if (firstStart) {
          // If first start, then load messages from api.
          setState(() {
            messages = event.messages.hydraMember;
            messagesTotalItemCount = event.messages.hydraTotalItems;
            firstStart = false;
          });

          return;
        }

        if (refetching) {
          //When refetch button pressed, give user cached messages,
          //as it will be updated anyway in the next fetch.
          setState(() {
            messages = messagesFromCache.hydraMember;
            messagesTotalItemCount = messagesFromCache.hydraTotalItems;
            refetching = false;
          });
        }

        final isExistsInCache = messagesFromCache.hydraMember!
            .where(
                (element) => element.id == event.messages.hydraMember?.first.id)
            .isNotEmpty;
        if (!isExistsInCache) {
          // If message is not in cache, then add it to cache
          addNewMessage(event.messages.hydraMember!.first);
          FlutterLocalNotificationsPlugin().show(
              Random().nextInt(9999),
              event.messages.hydraMember!.first.subject,
              event.messages.hydraMember!.first.intro,
              NotificationDetails(
                macOS: MacOSNotificationDetails(
                  sound: 'default',
                  subtitle: event.messages.hydraMember!.first.intro,
                ),
              ));

          setState(() {
            messages?.add(event.messages.hydraMember!.first);
            messagesTotalItemCount = event.messages.hydraTotalItems;
          });
        }
      }
    });

    BlocProvider.of<MessagesCubit>(context).loadFromCache();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await fetchMessages();
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

  Future<void> refetchMessages() async {
    setState(() {
      messages = [];
      refetching = true;
    });
    await fetchMessages();
  }

  Future<void> deleteMail(String messageId, int index) async {
    await BlocProvider.of<MessagesCubit>(context).deleteMessage(messageId);
    setState(() {
      messages?.removeAt(index);
    });
  }

  deleteMessages() {
    Future deleteAllMessages() async {
      Navigator.of(context).pop();
      final removed =
          await BlocProvider.of<MessagesCubit>(context).deleteMessages();

      if (removed) {
        setState(() {
          messages = [];
          messagesTotalItemCount = 0;
        });
      }
    }

    return showMacosAlertDialog<bool>(
      context: context,
      builder: (context) {
        return MacosAlertDialog(
          appIcon: const MacosIcon(CupertinoIcons.delete_solid,
              color: Colors.redAccent),
          title: const Text('Delete all messages'),
          message: const Text('Are you sure you want to delete all messages?'),
          primaryButton: PushButton(
            buttonSize: ButtonSize.large,
            child: const Text('Delete'),
            onPressed: deleteAllMessages,
          ),
          secondaryButton: PushButton(
            buttonSize: ButtonSize.large,
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
            isSecondary: true,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sort messages by seen status.
    messages?.sort((a, b) => a.seen ? 1 : 0);

    return CupertinoTabView(
      builder: (context) {
        return MacosScaffold(
          titleBar: TitleBar(
            actions: [
              TextButton.icon(
                label: const Text(""),
                icon: const MacosIcon(
                  CupertinoIcons.delete,
                  color: Colors.redAccent,
                ),
                onPressed: deleteMessages,
              ),
              TextButton.icon(
                  label: const Text(""),
                  icon: const MacosIcon(
                    CupertinoIcons.refresh,
                    color: MacosColors.appleBlue,
                  ),
                  onPressed: refetchMessages),
            ],
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
                    deleteMessage: (messageId, index) =>
                        deleteMail(messageId, index),
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
      required this.onTap,
      required this.deleteMessage})
      : super(key: key);

  final List<HydraMember>? messages;
  final String? messageId;
  final Function onTap;
  final Function deleteMessage;

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

            return NativeContextMenu.ContextMenuRegion(
              onItemSelected: (item) async {
                if (item.action == "delete") {
                  await deleteMessage(message.id, index);

                  return;
                }
              },
              menuItems: [
                NativeContextMenu.MenuItem(
                    title: "Delete mail", action: "delete")
              ],
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    onTap(message.id, index);
                  },
                  child: Container(
                    padding: messageId == message.id
                        ? const EdgeInsets.all(5)
                        : const EdgeInsets.only(left: 5),
                    margin: messageId == message.id
                        ? const EdgeInsets.all(10)
                        : null,
                    decoration: messageId == message.id
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(0, 0, 0, 0.2))
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(message.from?.name ??
                                          "Unknown sender"),
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
