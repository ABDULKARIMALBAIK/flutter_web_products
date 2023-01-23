import 'package:flutter/material.dart';

/* Column */

class WrapColumn extends StatelessWidget {
  const WrapColumn(
      {required this.children,
      this.wrapAlignment = WrapAlignment.start,
      this.sectionAlignment = WrapAlignment.start,
      this.wrapCrossAlignment = WrapCrossAlignment.start,
      this.spacing = 5,
      this.sectionSpacing = 5,
      this.clipBehavior = Clip.none,
      Key? key})
      : super(key: key);

  final WrapAlignment wrapAlignment;
  final WrapAlignment sectionAlignment;
  final WrapCrossAlignment wrapCrossAlignment;
  final Axis _direction = Axis.vertical;
  final double spacing;
  final double sectionSpacing;
  final Clip clipBehavior;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        alignment: wrapAlignment,
        runAlignment: sectionAlignment,
        crossAxisAlignment: wrapCrossAlignment,
        direction: _direction,
        spacing: spacing,
        runSpacing: sectionSpacing,
        clipBehavior: clipBehavior,
        children: children);
  }
}

/* Row */

class WrapRow extends StatelessWidget {
  const WrapRow(
      {required this.children,
      this.wrapAlignment = WrapAlignment.start,
      this.sectionAlignment = WrapAlignment.start,
      this.wrapCrossAlignment = WrapCrossAlignment.start,
      this.spacing = 5,
      this.sectionSpacing = 5,
      this.clipBehavior = Clip.none,
      Key? key})
      : super(key: key);

  final WrapAlignment wrapAlignment;
  final WrapAlignment sectionAlignment;
  final WrapCrossAlignment wrapCrossAlignment;
  final Axis _direction = Axis.horizontal;
  final double spacing;
  final double sectionSpacing;
  final Clip clipBehavior;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        alignment: wrapAlignment,
        runAlignment: sectionAlignment,
        crossAxisAlignment: wrapCrossAlignment,
        direction: _direction,
        spacing: spacing,
        runSpacing: sectionSpacing,
        clipBehavior: clipBehavior,
        children: children);
  }
}
