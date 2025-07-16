import 'package:flutter/material.dart';
import '../ui/timeline_widget.dart';
import 'page_container.dart';
import 'scrollable_content.dart';

class TimeWrap extends StatelessWidget {
  final Widget? header;
  final Widget content;
  final Color? backgroundColor;
  final Border? customBorder;

  const TimeWrap({
    super.key,
    this.header,
    required this.content,
    this.backgroundColor,
    this.customBorder,
  });

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      header: header,
      backgroundColor: backgroundColor,
      customBorder: customBorder,
      content: Column(
        children: [
          // Scrollable content area
          Expanded(
            child: ScrollableContent(
              child: content,
            ),
          ),
          // Fixed timeline widget at bottom with 20px padding
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: TimelineWidget(),
          ),
        ],
      ),
    );
  }
} 