import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:spamify/core/constants/theme.dart';

class MessageComponent extends StatelessWidget {
  const MessageComponent({
    super.key,
    required this.from,
    required this.description,
    required this.date,
    required this.onPressed,
    required this.selected,
  });

  final String from;
  final String description;
  final DateTime date;
  final VoidCallback onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final formattedDate = Jiffy(date).fromNow();

    return GestureDetector(
      onTap: onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          color: selected ? MacosColors.appleBlue : null,
          child: Padding(
            padding: EdgeInsets.all(ThemePadding.small.padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        from,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: selected ? MacosColors.white : null),
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: selected ? MacosColors.white : null),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
                Text(
                  description,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: selected ? MacosColors.white : null),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
