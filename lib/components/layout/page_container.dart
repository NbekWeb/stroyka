import 'package:flutter/material.dart';
import 'styles/page_container_styles.dart';

class PageContainer extends StatelessWidget {
  final Widget? header;
  final Widget content;
  final Color? backgroundColor;
  final Border? customBorder;

  const PageContainer({
    super.key,
    this.header,
    required this.content,
    this.backgroundColor,
    this.customBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? PageContainerStyles.defaultBackgroundColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            border: customBorder ?? PageContainerStyles.defaultBorder,
          ),
          child: Column(
            children: [
              if (header != null) header!,
              Expanded(child: content),
            ],
          ),
        ),
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  const PageHeader({
    super.key,
    required this.title,
    this.trailing,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? PageHeaderStyles.defaultPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: PageHeaderStyles.titleTextStyle,
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
} 