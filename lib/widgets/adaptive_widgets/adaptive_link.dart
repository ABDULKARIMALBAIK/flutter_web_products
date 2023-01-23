import 'package:flutter/material.dart'
    show
        Widget,
        StatelessWidget,
        VoidCallback,
        Key,
        BuildContext,
        Semantics,
        MouseRegion,
        SystemMouseCursors,
        GestureDetector;
import 'package:seo_renderer/seo_renderer.dart' show LinkRenderer;
import 'package:url_launcher/link.dart';

import '../../utils/platform_detector.dart';

// ignore: must_be_immutable
class AdaptiveLink extends StatelessWidget {
  final Widget widget;
  final String link;
  final String linkText;
  final LinkTarget target;
  final String hint;
  final String label;
  final String value;
  VoidCallback? onTap;

  AdaptiveLink({
    Key? key,
    required this.widget,
    required this.link,
    required this.linkText,
    this.target = LinkTarget.blank,
    this.onTap,
    this.hint = '',
    this.label = '',
    this.value = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformDetector().isWeb()
        ? LinkRenderer(
            href: link,
            text: linkText,
            child: _widgetLink(context),
          )
        : _widgetLink(context);
  }

  _widgetLink(BuildContext context) {
    return Semantics(
      readOnly: true,
      link: true,
      value: value,
      label: label,
      hint: hint,
      child: Link(
        uri: Uri.parse(link),
        target: target,
        builder: (context, followLink) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onTap,
              child: widget,
            ),
          );
        },
      ),
    );
  }
}
