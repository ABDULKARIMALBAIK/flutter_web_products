import 'package:flutter/material.dart'
    show
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
        Radius,
        ToolbarOptions,
        Text;
import 'package:seo_renderer/seo_renderer.dart'
    show TextRendererStyle, TextRenderer;

import '../../utils/platform_detector.dart';

class AdaptiveText extends StatelessWidget {
  final String text;
  final String headerText;
  final TextRendererStyle headerType;
  final TextStyle style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow textOverflow;
  final String hint;
  final String label;
  final String value;
  final double? textScaleFactor;

  const AdaptiveText(
      {Key? key,
      required this.text,
      required this.headerText,
      required this.headerType,
      required this.style,
      this.textAlign = TextAlign.start,
      this.textOverflow = TextOverflow.ellipsis,
      this.textScaleFactor,
      this.maxLines,
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
                child: SelectableText(
                  text,
                  cursorColor: Theme.of(context).primaryColor,
                  style: style,
                  cursorWidth: 2,
                  maxLines: maxLines,
                  textAlign: textAlign,
                  cursorRadius: const Radius.circular(20),
                  enableInteractiveSelection: true,
                  textScaleFactor: textScaleFactor,
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
            child: Text(
              text,
              style: style,
              textAlign: textAlign,
              overflow: textOverflow,
              semanticsLabel: label,
              textScaleFactor: textScaleFactor,
            ),
          );
  }
}
