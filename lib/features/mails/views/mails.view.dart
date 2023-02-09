import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/features/mails/controller/messages.controller.dart';
import 'package:spamify/features/mails/views/components/message.component.dart';
import 'package:spamify/services/di.service.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

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

    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: _toolbar(),
      children: [
        ResizablePane(
          builder: (context, scrollController) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final message = controller.messages[index];

                  return Observer(
                    builder: (context) {
                      if (controller.deleteMode) {
                        final checkboxValue = controller.selectedMessages
                                .where((element) =>
                                    element.hydraMemberId ==
                                    message.hydraMemberId)
                                .toList()
                                .isNotEmpty
                            ? true
                            : false;

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MacosCheckbox(
                              value: checkboxValue,
                              onChanged: (value) =>
                                  controller.toggleMessageCheckbox(
                                      controller.messages[index]),
                            ),
                            Expanded(
                              child: MessageComponent(
                                from: message.from.name,
                                description: message.subject,
                                date: message.createdAt,
                                onPressed: () =>
                                    controller.fetchMessage(message),
                              ),
                            )
                          ],
                        );
                      }

                      return MessageComponent(
                        from: message.from.name,
                        description: message.subject,
                        date: message.createdAt,
                        onPressed: () => controller.fetchMessage(message),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: controller.messages.length);
          },
          startWidth: 250,
          maxWidth: 300,
          minWidth: 150,
          resizableSide: ResizableSide.right,
          isResizable: true,
        ),
        ContentArea(
          builder: (context) {
            return Observer(builder: (_) {
              if (controller.isFetchingSingleMessage) {
                return const Center(
                  child: ProgressCircle(
                    value: null,
                  ),
                );
              }

              return HtmlWidget(
                controller.showingMessage?.html[0] ?? "",
                onTapUrl: controller.onTapUrl,
                enableCaching: true,
                buildAsync: true,
                renderMode: RenderMode.listView,
                rebuildTriggers: RebuildTriggers([]),
                onLoadingBuilder: (_, __, v) => ProgressCircle(
                  value: v,
                ),
                onErrorBuilder: (context, element, error) {
                  Text(error);
                  return null;
                },
              );
            });
          },
        ),
      ],
    );
  }

  ToolBar _toolbar() {
    return ToolBar(
      leading: IconButton(
        onPressed: _toggleSidebar,
        icon: const MacosIcon(CupertinoIcons.line_horizontal_3),
      ),
      actions: [
        ToolBarIconButton(
          label: "Select",
          showLabel: true,
          tooltipMessage: "Delete one or more messages",
          icon: const MacosIcon(
            CupertinoIcons.square_pencil,
          ),
          onPressed: controller.toggleDeleteMode,
        ),
        const ToolBarIconButton(
          label: "Refresh",
          showLabel: true,
          icon: MacosIcon(
            CupertinoIcons.refresh,
            color: MacosColors.appleBlue,
          ),
          // onPressed: refetchMessages,
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

  void _toggleSidebar() {
    MacosWindowScope.of(context).toggleSidebar();
  }
}
