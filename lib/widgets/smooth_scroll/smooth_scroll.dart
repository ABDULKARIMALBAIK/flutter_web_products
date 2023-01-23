import 'package:flutter/material.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';

import 'custom_scroll_behavior.dart';

class SmoothScroll extends StatelessWidget {
  SmoothScroll(
      {required this.scrollController,
      required this.scrollView,
      this.scrollPhysics = const BouncingScrollPhysics(),
      Key? key})
      : super(key: key) {
    assert(
        scrollView is ListView ||
            scrollView is GridView ||
            scrollView is SingleChildScrollView,
        'Please use ListView , GridView , SingleChildScrollView');
  }

  ScrollController scrollController;
  ScrollPhysics scrollPhysics;
  Widget scrollView;

  @override
  Widget build(BuildContext context) {
    return checkDesktop(context)
        ? _desktopWebScroll(context)
        : _singleScrollChild(context);
  }

  _desktopWebScroll(BuildContext context) {
    return ImprovedScrolling(
        scrollController: scrollController,
        mmbScrollConfig: const MMBScrollConfig(
          customScrollCursor: DefaultCustomScrollCursor(),
        ),
        keyboardScrollConfig: KeyboardScrollConfig(
          homeScrollDurationBuilder: (currentScrollOffset, minScrollOffset) {
            return const Duration(milliseconds: 100);
          },
          endScrollDurationBuilder: (currentScrollOffset, maxScrollOffset) {
            return const Duration(milliseconds: 2000);
          },
        ),
        customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
          scrollAmountMultiplier: 2.0,
        ),
        onScroll: (scrollOffset) {
          //print(Scroll offset: $scrollOffset',),
        },
        onMMBScrollStateChanged: (scrolling) {
          //print('Is scrolling: $scrolling',)
        },
        onMMBScrollCursorPositionUpdate: (localCursorOffset, scrollActivity) {
          //print('Cursor position: $localCursorOffset\n''Scroll activity: $scrollActivity',)
        },
        enableMMBScrolling: true,
        enableKeyboardScrolling: true,
        enableCustomMouseWheelScrolling: true,
        child: ScrollConfiguration(
          behavior: const CustomScrollBehavior(),
          child: _singleScrollChild(context),
        ));
  }

  _singleScrollChild(BuildContext context) {
    return scrollView;
  }

  static checkDesktop(BuildContext context) {
    return (Theme.of(context).platform == TargetPlatform.windows ||
        Theme.of(context).platform == TargetPlatform.linux ||
        Theme.of(context).platform == TargetPlatform.macOS ||
        Theme.of(context).platform == TargetPlatform.fuchsia);
  }
}

/*
PlatformDetector().isWeb() &&
                (Theme.of(context).platform == TargetPlatform.iOS ||
                    Theme.of(context).platform == TargetPlatform.android)






PlatformDetector().isWeb() &&
                  (Theme.of(context).platform == TargetPlatform.windows ||
                      Theme.of(context).platform == TargetPlatform.linux ||
                      Theme.of(context).platform == TargetPlatform.macOS ||
                      Theme.of(context).platform == TargetPlatform.fuchsia)
              ? const NeverScrollableScrollPhysics()

 */
