import 'package:flutter/material.dart'
    show
        InlineSpan,
        StatelessWidget,
        TextStyle,
        TextAlign,
        TextOverflow,
        Key,
        Widget,
        BuildContext,
        Semantics,
        TextSelectionTheme,
        TextSelectionThemeData,
        Theme,
        SelectableText,
        TextSpan,
        Radius,
        ToolbarOptions,
        RichText;
import 'package:seo_renderer/seo_renderer.dart'
    show TextRenderer, TextRendererStyle;

import '../../utils/platform_detector.dart';

class AdaptiveRichText extends StatelessWidget {
  final List<InlineSpan> textSpanChildren;
  final String headerText;
  final TextRendererStyle headerType;
  final TextStyle style;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final String hint;
  final String label;
  final String value;

  const AdaptiveRichText(
      {Key? key,
      required this.textSpanChildren,
      required this.headerText,
      required this.style,
      required this.headerType,
      this.textAlign = TextAlign.start,
      this.textOverflow = TextOverflow.ellipsis,
      this.label = '',
      this.hint = '',
      this.value = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformDetector().isWeb()
        ? TextRenderer(
            style: headerType,
            text: headerText,
            child: Semantics(
              onTap: () {},
              selected: true,
              readOnly: true,
              header: true,
              value: value,
              label: label,
              hint: hint,
              child: TextSelectionTheme(
                data: TextSelectionThemeData(
                  cursorColor: Theme.of(context).primaryColor,
                  selectionColor:
                      Theme.of(context).primaryColor.withOpacity(0.5),
                  selectionHandleColor:
                      Theme.of(context).primaryColor.withOpacity(0.5),
                ),
                child: SelectableText.rich(
                  TextSpan(style: style, children: textSpanChildren),
                  style: style,
                  cursorColor: Theme.of(context).primaryColor,
                  cursorWidth: 2,
                  textAlign: textAlign,
                  cursorRadius: const Radius.circular(20),
                  enableInteractiveSelection: true,
                  toolbarOptions:
                      const ToolbarOptions(copy: true, selectAll: true),
                  onSelectionChanged: (selection, cause) {},
                ),
              ),
            ),
          )
        : Semantics(
            onTap: () {},
            selected: true,
            readOnly: true,
            header: true,
            value: value,
            label: label,
            hint: hint,
            child: RichText(
              text: TextSpan(style: style, children: textSpanChildren),
            ),
          );
  }
}
