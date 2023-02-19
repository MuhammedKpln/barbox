import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/core/constants/theme.dart';
import 'package:spamify/core/services/router.service.dart';
import 'package:spamify/features/mails/controller/messages.controller.dart';
import 'package:spamify/features/mails/models/message.model.dart';
import 'package:spamify/features/mails/views/components/message.component.dart';
import 'package:spamify/core/services/di.service.dart';

class MailsView extends StatefulWidget {
  const MailsView({super.key});

  @override
  State<MailsView> createState() => _MailsViewState();
}

class _MailsViewState extends State<MailsView> {
  final controller = getIt<MessagesController>();

  @override
  void initState() {
    super.initState();
    _toggleSidebar();

    controller.init();
  }

  _toggleSidebar() {
    Future.delayed(const Duration(milliseconds: 200),
        () => MacosWindowScope.of(context).toggleSidebar());
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: _toolbar(),
      children: [
        ResizablePane(
          builder: (context, scrollController) {
            return StreamBuilder<List<Message>>(
                stream: controller.messages.stream,
                initialData: const [],
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Text("selam");
                    case ConnectionState.waiting:
                      return const Center(
                        child: ProgressCircle(value: null),
                      );
                    case ConnectionState.active:
                      final data = snapshot.data;

                      return Observer(
                        builder: (context) {
                          print(controller.deleteMode);
                          print(controller.selectedMessages);

                          return ListView.separated(
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                final message = data[index];

                                if (controller.deleteMode) {
                                  final checkboxValue = controller
                                          .selectedMessages
                                          .where((element) =>
                                              element.primaryId ==
                                              message.primaryId)
                                          .toList()
                                          .isNotEmpty
                                      ? true
                                      : false;

                                  return Padding(
                                    padding: EdgeInsets.all(
                                        ThemePadding.medium.padding),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        MacosCheckbox(
                                          value: checkboxValue,
                                          onChanged: (value) =>
                                              controller.toggleMessageCheckbox(
                                                  data[index]),
                                        ),
                                        Expanded(
                                          child: MessageComponent(
                                            from: message.from.name,
                                            description: message.subject,
                                            date: message.createdAt,
                                            onPressed: () => controller
                                                .toggleMessageCheckbox(
                                                    data[index]),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }

                                return MessageComponent(
                                  from: message.from.name,
                                  description: message.subject,
                                  date: message.createdAt,
                                  onPressed: () =>
                                      mailsRouterDelegate.beamToNamed(
                                          "/inbox/${message.primaryId}",
                                          data: message),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: data!.length);
                        },
                      );

                    case ConnectionState.done:
                      return const Text("Done");
                  }
                });
          },
          startWidth: 250,
          maxWidth: 300,
          minWidth: 150,
          resizableSide: ResizableSide.right,
          isResizable: true,
        ),
        ContentArea(
          builder: (context, _) {
            return Beamer(
              routerDelegate: mailsRouterDelegate,
              key: mailsRouterKey,
            );
          },
        ),
      ],
    );
  }

  ToolBar _toolbar() {
    return ToolBar(
      leading: MacosIconButton(
        onPressed: _toggleSidebar,
        icon: const MacosIcon(CupertinoIcons.line_horizontal_3),
      ),
      actions: [
        ToolBarIconButton(
          label: "Select",
          showLabel: true,
          tooltipMessage: "Select one or more messages",
          icon: const MacosIcon(
            CupertinoIcons.checkmark_alt_circle,
          ),
          onPressed: controller.toggleDeleteMode,
        ),
        ToolBarIconButton(
          label: "Refresh",
          showLabel: true,
          icon: const MacosIcon(
            CupertinoIcons.refresh,
          ),
          onPressed: controller.fetchMessages,
        ),
        CustomToolbarItem(
          inToolbarBuilder: (context) {
            return Observer(
              builder: (context) {
                if (controller.selectedMessages.isEmpty) {
                  return const SizedBox.shrink();
                }

                return ToolBarIconButton(
                  label: "Delete",
                  showLabel: true,
                  tooltipMessage: "Delete one or more messages",
                  icon: const MacosIcon(
                    CupertinoIcons.delete,
                    color: Colors.redAccent,
                  ),
                  onPressed: controller.deleteMessages,
                ).build(context, ToolbarItemDisplayMode.inToolbar);
              },
            );
          },
        ),
      ],
      title: const Text("Inbox"),
    );
  }
}
