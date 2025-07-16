import 'package:flutter/material.dart';
import 'styles/scrollable_content_styles.dart';

class ScrollableContent extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool? reverse;

  const ScrollableContent({
    super.key,
    required this.child,
    this.padding,
    this.controller,
    this.primary,
    this.physics,
    this.reverse,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      primary: primary,
      physics: physics ?? ScrollableContentStyles.defaultPhysics,
      reverse: reverse ?? ScrollableContentStyles.defaultReverse,
      padding: padding ?? ScrollableContentStyles.defaultPadding,
      child: child,
    );
  }
}

class ScrollablePageContent extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? contentPadding;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool? reverse;

  const ScrollablePageContent({
    super.key,
    required this.child,
    this.contentPadding,
    this.controller,
    this.primary,
    this.physics,
    this.reverse,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollableContent(
        controller: controller,
        primary: primary,
        physics: physics,
        reverse: reverse,
        padding: contentPadding,
        child: child,
      ),
    );
  }
} 