import 'package:flutter/material.dart'
    show
        Widget,
        BuildContext,
        MaterialScrollBehavior,
        ScrollableDetails,
        TargetPlatform,
        Scrollbar;

class CustomScrollBehavior extends MaterialScrollBehavior {
  const CustomScrollBehavior();

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
        return Scrollbar(
          controller: details.controller,
          // isAlwaysShown: true,
          child: child,
        );
      case TargetPlatform.windows:
        return Scrollbar(
          controller: details.controller,
          // isAlwaysShown: true,
          // radius: Radius.zero,
          // thickness: 16.0,
          // hoverThickness: 16.0,
          // showTrackOnHover: true,
          child: child,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return child;
    }
  }
}
