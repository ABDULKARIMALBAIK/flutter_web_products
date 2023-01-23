import 'dart:ui' as ui;

import 'package:flutter/material.dart'
    show
        StatefulWidget,
        State,
        IgnorePointer,
        HtmlElementView,
        Widget,
        BuildContext,
        Semantics,
        SizedBox;
import 'package:seo_renderer/seo_renderer.dart' show ImageRenderer;
import 'package:universal_html/html.dart' as html;

import '../../utils/platform_detector.dart';

// ignore: must_be_immutable
class AdaptiveImage extends StatefulWidget {
  final String srcImage;
  final String altImage;
  final double width;
  final double height;
  final String hint;
  final String label;
  final String value;
  final Widget? nativeImage;

  final String imageName;

  const AdaptiveImage({
    required key,
    required this.srcImage,
    required this.altImage,
    required this.width,
    required this.height,
    required this.imageName,
    this.nativeImage,
    this.label = '',
    this.hint = '',
    this.value = '',
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AdaptiveImageState();
}

class _AdaptiveImageState extends State<AdaptiveImage> {
  @override
  initState() {
    html.ImageElement _element = html.ImageElement(src: widget.srcImage)
      ..style.width = "${widget.width}px"
      ..style.height = "${widget.height}px"
      ..alt = widget.altImage
      ..style.padding = '0px'
      ..style.margin = '0px';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory(widget.imageName, (int viewId) => _element);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformDetector().isWeb()
        ? SizedBox(
            width: widget.width,
            height: widget.height,
            child: ImageRenderer(
              src: widget.srcImage,
              alt: widget.altImage,
              child: Semantics(
                  onTap: () {},
                  readOnly: true,
                  image: true,
                  value: widget.value,
                  label: widget.label,
                  hint: widget.hint,
                  child: IgnorePointer(
                    child: HtmlElementView(
                      key: widget.key,
                      viewType: widget.imageName,
                    ),
                  )),
            ),
          )
        : Semantics(
            onTap: () {},
            readOnly: true,
            image: true,
            value: widget.value,
            label: widget.label,
            hint: widget.hint,
            child: widget.nativeImage);
  }
}
