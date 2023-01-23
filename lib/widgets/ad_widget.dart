import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:ui' as ui;

// ignore: must_be_immutable
class AdWidget extends StatefulWidget {
  final double width;
  final double height;
  final String hint;
  final String label;
  final String value;

  final String adName;

  const AdWidget({
    required key,
    required this.width,
    required this.height,
    required this.adName,
    this.label = '',
    this.hint = '',
    this.value = '',
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  @override
  initState() {
    html.IFrameElement _element = html.IFrameElement()
      ..style.width = "${widget.width}px"
      ..style.height = "${widget.height}px"
      ..width = "${widget.width}px"
      ..height = "${widget.height}px"
      ..style.padding = '0px'
      ..style.margin = '0px'
      ..style.border = 'none'
      ..srcdoc = """<!DOCTYPE html><html>
                    <head>
                    <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
                    </head>
                    <body scroll="no" style="overflow: hidden">
                      
                        <ins class="adsbygoogle"
                             style="display:block; width:${widget.width}px; height:${widget.height}px"
                             data-ad-client="ca-pub-3199660652950290"
                             data-ad-slot="6259591966"
                             data-ad-test="on"
                             data-ad-format="auto"
                             data-full-width-responsive="true"
                             ></ins>
                        <script>
                             (adsbygoogle = window.adsbygoogle || []).push({});
                        </script>
                    </body>
                  </html>""";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory(widget.adName, (int viewId) => _element);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Semantics(
          onTap: () {},
          readOnly: true,
          link: true,
          value: widget.value,
          label: widget.label,
          hint: widget.hint,
          child: IgnorePointer(
            child: HtmlElementView(
              key: widget.key,
              viewType: widget.adName,
            ),
          )),
    );
  }
}
