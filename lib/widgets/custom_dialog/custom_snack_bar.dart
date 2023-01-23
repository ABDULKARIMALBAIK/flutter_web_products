import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Popup widget that you can use by default to show some information
class CustomSnackBar extends StatefulWidget {
  final String message;
  final Widget icon;
  final Color backgroundColor;
  final TextStyle textStyle;
  final int maxLines;
  final int iconRotationAngle;
  final List<BoxShadow> boxShadow;
  final BorderRadius borderRadius;
  final double iconPositionTop;
  final double iconPositionLeft;
  final EdgeInsetsGeometry messagePadding;
  final double textScaleFactor;

  const CustomSnackBar.success({
    Key? key,
    required this.message,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.icon = const FaIcon(
      FontAwesomeIcons.faceGrin,
      color: Color(0x15000000),
      size: 100,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: Colors.white,
    ),
    this.maxLines = 2,
    this.iconRotationAngle = 32,
    this.iconPositionTop = 0, //-10
    this.iconPositionLeft = 0, //-8
    this.backgroundColor = const Color(0xff00E676),
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
  }) : super(key: key);

  const CustomSnackBar.info({
    Key? key,
    required this.message,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.icon = const FaIcon(
      FontAwesomeIcons.faceFlushed, //Icons.sentiment_neutral
      color: Color(0x15000000),
      size: 100,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: Colors.white,
    ),
    this.maxLines = 2,
    this.iconRotationAngle = 32,
    this.iconPositionTop = 0, //-10
    this.iconPositionLeft = 0, //-8
    this.backgroundColor = const Color(0xff2196F3),
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
  }) : super(key: key);

  const CustomSnackBar.error({
    Key? key,
    required this.message,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.icon = const FaIcon(
      FontAwesomeIcons.faceDizzy, //Icons.error_outline
      color: Color(0x15000000),
      size: 100,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: Colors.white,
    ),
    this.maxLines = 2,
    this.iconRotationAngle = 32,
    this.iconPositionTop = 0, //-10
    this.iconPositionLeft = 0, //-8
    this.backgroundColor = const Color(0xffff5252),
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
  }) : super(key: key);

  const CustomSnackBar.cookies({
    Key? key,
    required this.message,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.icon = const FaIcon(
      FontAwesomeIcons.cookieBite,
      color: Color(0x15000000),
      size: 100,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: Colors.white,
    ),
    this.maxLines = 2,
    this.iconRotationAngle = 32,
    this.iconPositionTop = 0, //-10
    this.iconPositionLeft = 0, //-8
    this.backgroundColor = const Color(0xffff8352),
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
  }) : super(key: key);

  @override
  _CustomSnackBarState createState() => _CustomSnackBarState();
}

class _CustomSnackBarState extends State<CustomSnackBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 100,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow,
      ),
      width: 400,
      child: Stack(
        children: [
          Positioned(
            top: widget.iconPositionTop,
            left: widget.iconPositionLeft,
            child: SizedBox(
              height: 95,
              child: Transform.rotate(
                angle: widget.iconRotationAngle * pi / 180,
                child: widget.icon,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: widget.messagePadding,
              child: Text(
                widget.message,
                style: theme.textTheme.bodyText2?.merge(
                  widget.textStyle,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: widget.maxLines,
                textScaleFactor: widget.textScaleFactor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const kDefaultBoxShadow = [
  BoxShadow(
    color: Colors.black26,
    offset: Offset(0.0, 8.0),
    spreadRadius: 1,
    blurRadius: 30,
  ),
];

const kDefaultBorderRadius = BorderRadius.all(Radius.circular(12));
