import 'dart:async';

import 'package:barbox/core/constants/theme.dart';
import 'package:barbox/core/services/di.service.dart';
import 'package:barbox/core/services/router/router.controller.dart';
import 'package:barbox/core/services/router/router.service.dart';
import 'package:barbox/features/mails/controller/messages.controller.dart';
import 'package:barbox/features/mails/views/components/message.component.dart';
import 'package:barbox/types/messages/message.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macos_ui/macos_ui.dart';

class MailsView extends StatefulWidget {
  const MailsView({super.key});

  @override
  State<MailsView> createState() => _MailsViewState();
}

class _MailsViewState extends State<MailsView> {
  final controller = getIt<MessagesController>();
  final _routerService = getIt<RouterServiceController>();

  @override
  void initState() {
    super.initState();
    _toggleSidebar();

    controller.init();
  }

  @override
  void dispose() {
    getIt.resetLazySingleton<MessagesController>();
    super.dispose();
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
                      snapshot.data?.sort((a, b) => a.seen ? 1 : 0);
                      final data = snapshot.data;

                      if (data!.isEmpty) {
                        return const Center(child: Text("No new messages"));
                      }

                      return Observer(
                        builder: (context) {
                          debugPrint(controller.selectMode.toString());
                          debugPrint(controller.selectedMessages.toString());

                          final currentRouteLocation =
                              _routerService.currentRoute?.location;

                          return ListView.separated(
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                final message = data[index];
                                final isSelected = currentRouteLocation ==
                                    "/inbox/${message.id}";

                                if (controller.selectMode) {
                                  final checkboxValue = controller
                                          .selectedMessages
                                          .where((element) =>
                                              element.id == message.id)
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
                                              from: message.from.name!,
                                              description:
                                                  message.subject ?? "Wewe",
                                              date: message.createdAt,
                                              onPressed: () => controller
                                                  .toggleMessageCheckbox(
                                                      data[index]),
                                              selected: false,
                                              seen: message.seen),
                                        )
                                      ],
                                    ),
                                  );
                                }

                                return MessageComponent(
                                    from: message.from.name!,
                                    description: message.subject ?? "sssd",
                                    date: message.createdAt,
                                    onPressed: () => mailsRouterDelegate
                                        .beamToNamed("/inbox/${message.id}",
                                            data: message),
                                    selected: isSelected,
                                    seen: message.seen);
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: data.length);
                        },
                      );

                    case ConnectionState.done:
                      return const Text("Done");
                  }
                });
          },
          resizableSide: ResizableSide.right,
          isResizable: true,
          minSize: 150,
          startSize: 250,
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
          label: "Copy address",
          showLabel: true,
          tooltipMessage: "Copy your address",
          icon: const MacosIcon(
            CupertinoIcons.doc_on_doc,
          ),
          onPressed: controller.copyAddress,
        ),
        const ToolBarDivider(),
        ToolBarIconButton(
          label: "Select",
          showLabel: true,
          tooltipMessage: "Select one or more messages",
          icon: const MacosIcon(
            CupertinoIcons.checkmark_alt_circle,
          ),
          onPressed: controller.toggleSelectMode,
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
        CustomToolbarItem(
          inToolbarBuilder: (context) {
            return Observer(
              builder: (context) {
                if (controller.selectedMessages.isEmpty) {
                  return const SizedBox.shrink();
                }

                final isMarkedUnseenMessage = controller.selectedMessages
                    .where((element) => element.seen == true)
                    .isEmpty;

                if (isMarkedUnseenMessage) {
                  return ToolBarIconButton(
                    label: "Mark as unseen",
                    showLabel: true,
                    tooltipMessage: "Mark as unseen",
                    icon: const MacosIcon(
                      CupertinoIcons.check_mark_circled_solid,
                    ),
                    onPressed: controller.bulkMarkAsSeen,
                  ).build(context, ToolbarItemDisplayMode.inToolbar);
                }

                return const SizedBox.shrink();
              },
            );
          },
        ),
      ],
      title: Observer(
          builder: (_) => Text(
                "Inbox - ${controller.currentAccount?.address}",
                style: MacosTheme.of(context).typography.headline,
              )),
    );
  }
}
