import 'package:barbox/core/services/di.service.dart';
import 'package:barbox/features/mails/controller/message.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:macos_ui/macos_ui.dart';

class MailView extends StatefulWidget {
  const MailView({super.key, required this.msgId});

  final String msgId;

  @override
  State<MailView> createState() => _MailViewState();
}

class _MailViewState extends State<MailView> {
  final controller = getIt<MessageController>();

  @override
  void initState() {
    super.initState();
    controller.init(msgId: widget.msgId);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (controller.isLoading) {
        return const Center(
          child: ProgressCircle(
            value: null,
          ),
        );
      }

      final html = controller.message != null
          ? controller.message!.html.isNotEmpty
              ? controller.message?.html[0]
              : "NO MESSAGE BODY"
          : "NULL";

      return HtmlWidget(
        html ?? "NULL",
        onTapUrl: controller.onTapUrl,
        enableCaching: true,
        buildAsync: true,
        renderMode: RenderMode.listView,
        onLoadingBuilder: (_, __, v) => ProgressCircle(
          value: v,
        ),
        onErrorBuilder: (context, element, error) {
          Text(error);
          return null;
        },
      );
    });
  }
}
