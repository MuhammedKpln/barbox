import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/cubits/MessageCubit.dart';
import 'package:url_launcher/url_launcher.dart';

class Message extends StatefulWidget {
  const Message({Key? key, required this.messageId}) : super(key: key);

  final String messageId;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<MessageCubit>(context).getMessage(widget.messageId);
  }

  @override
  void didUpdateWidget(Message oldWidget) {
    super.didUpdateWidget(oldWidget);
    BlocProvider.of<MessageCubit>(context).getMessage(widget.messageId);
  }

  FutureOr<bool> onTapUrl(String url) async {
    await canLaunch(url) ? launch(url, forceSafariVC: true) : false;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageCubit, MessageSingleInitial>(
        builder: (context, state) {
          if (state is MessageSingleLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is MessageSingleCompleted) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: MacosTheme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            child: Text(state.response.from?.name![0] ?? "A"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.response.from?.name ?? "Unknown",
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    // Text(
                                    //   Moment.fromDateTime(
                                    //               message?.createdAt ?? DateTime.now())
                                    //           .fromNow() ??
                                    //       "Unknown date",
                                    //   style: TextStyle(
                                    //     fontSize: 13,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(
                                  width: 300,
                                  child: Text(
                                    state.response.subject ?? "Unknown subject",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                    style:
                                        MacosTheme.of(context).typography.body,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: MacosTheme.of(context).canvasColor,
                        ),
                        child: HtmlWidget(
                          state.response.html?[0] ?? "",
                          onTapUrl: onTapUrl,
                          enableCaching: true,
                          buildAsync: true,
                          rebuildTriggers: RebuildTriggers([]),
                        )),
                  ],
                ),
              ),
            );
          }

          return Container();
        },
        listener: (context, state) {});
  }
}
