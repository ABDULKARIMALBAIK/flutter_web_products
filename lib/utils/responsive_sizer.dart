import 'dart:math' show max, min;

import 'package:flutter/material.dart'
    show
        BuildContext,
        MediaQuery,
        TextStyle,
        Theme,
        Color,
        TextDecoration,
        FontWeight,
        FontStyle,
        TextOverflow,
        Shadow,
        // ignore: duplicate_shown_name
        TextOverflow,
        TextBaseline;

class ResponsiveSizer {
  static double ratioText = 13;

  static double responsiveWidth(BuildContext context, double constWidth) {
    double value = constWidth > MediaQuery.of(context).size.width
        ? constWidth - (MediaQuery.of(context).size.width / 5)
        : constWidth + (MediaQuery.of(context).size.width / 5);
    print('constWidth_$constWidth');
    print('value_$value');
    return value;
    // if (value > constWidth) {
    //   return constWidth;
    // } else {
    //   return value;
    // }
  }

  static double responsiveHeight(BuildContext context, double constHeight) {
    double value = constHeight * MediaQuery.of(context).size.height / 100;
    if (value > constHeight) {
      return constHeight;
    } else {
      return value;
    }
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static TextStyle responsiveText(
    BuildContext context,
    TextType textType, {
    double? minFontSize,
    double? maxFontSize,
    Color? color,
    Color? backgroundColor,
    TextDecoration? decoration,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? wordSpacing,
    TextOverflow? textOverflow,
    List<Shadow>? shadows,
    TextBaseline? textBaseline,
  }) {
    switch (textType) {
      case TextType.header1:
        return Theme.of(context).textTheme.headline1!.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              decoration: decoration,
              fontSize: responsiveFontSize(
                  context,
                  fontSize ?? Theme.of(context).textTheme.headline1!.fontSize,
                  minFontSize,
                  maxFontSize),
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              overflow: textOverflow,
              shadows: shadows,
              textBaseline: textBaseline,
            );
      case TextType.header2:
        return Theme.of(context).textTheme.headline2!.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              decoration: decoration,
              fontSize: responsiveFontSize(
                  context,
                  fontSize ?? Theme.of(context).textTheme.headline2!.fontSize,
                  minFontSize,
                  maxFontSize),
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              overflow: textOverflow,
              shadows: shadows,
              textBaseline: textBaseline,
            );
      case TextType.header3:
        return Theme.of(context).textTheme.headline3!.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              decoration: decoration,
              fontSize: responsiveFontSize(
                  context,
                  fontSize ?? Theme.of(context).textTheme.headline3!.fontSize,
                  minFontSize,
                  maxFontSize),
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              overflow: textOverflow,
              shadows: shadows,
              textBaseline: textBaseline,
            );
      case TextType.header4:
        return Theme.of(context).textTheme.headline4!.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              decoration: decoration,
              fontSize: responsiveFontSize(
                  context,
                  fontSize ?? Theme.of(context).textTheme.headline4!.fontSize,
                  minFontSize,
                  maxFontSize),
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              overflow: textOverflow,
              shadows: shadows,
              textBaseline: textBaseline,
            );
      case TextType.header5:
        return Theme.of(context).textTheme.headline5!.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              decoration: decoration,
              fontSize: responsiveFontSize(
                  context,
                  fontSize ?? Theme.of(context).textTheme.headline5!.fontSize,
                  minFontSize,
                  maxFontSize),
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              overflow: textOverflow,
              shadows: shadows,
              textBaseline: textBaseline,
            );
      case TextType.header6:
        return Theme.of(context).textTheme.headline6!.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              decoration: decoration,
              fontSize: responsiveFontSize(
                  context,
                  fontSize ?? Theme.of(context).textTheme.headline6!.fontSize,
                  minFontSize,
                  maxFontSize),
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              overflow: textOverflow,
              shadows: shadows,
              textBaseline: textBaseline,
            );
      case TextType.subtitle1:
        return Theme.of(context).textTheme.subtitle1!.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              decoration: decoration,
              fontSize: responsiveFontSize(
                  context,
                  fontSize ?? Theme.of(context).textTheme.subtitle1!.fontSize,
                  minFontSize,
                  maxFontSize),
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              overflow: textOverflow,
              shadows: shadows,
              textBaseline: textBaseline,
            );
      case TextType.subtitle2:
        return Theme.of(context).textTheme.subtitle2!.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              decoration: decoration,
              fontSize: responsiveFontSize(
                  context,
                  fontSize ?? Theme.of(context).textTheme.subtitle2!.fontSize,
                  minFontSize,
                  maxFontSize),
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              overflow: textOverflow,
              shadows: shadows,
              textBaseline: textBaseline,
            );
      case TextType.body1:
        return Theme.of(context).textTheme.bodyText1!.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              decoration: decoration,
              fontSize: responsiveFontSize(
                  context,
                  fontSize ?? Theme.of(context).textTheme.bodyText1!.fontSize,
                  minFontSize,
                  maxFontSize),
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              overflow: textOverflow,
              shadows: shadows,
              textBaseline: textBaseline,
            );
      case TextType.body2:
        return Theme.of(context).textTheme.bodyText2!.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              decoration: decoration,
              fontSize: responsiveFontSize(
                  context,
                  fontSize ?? Theme.of(context).textTheme.bodyText2!.fontSize,
                  minFontSize,
                  maxFontSize),
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              overflow: textOverflow,
              shadows: shadows,
              textBaseline: textBaseline,
            );
      case TextType.button:
        return Theme.of(context).textTheme.button!.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              decoration: decoration,
              fontSize: responsiveFontSize(
                  context,
                  fontSize ?? Theme.of(context).textTheme.button!.fontSize,
                  minFontSize,
                  maxFontSize),
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              overflow: textOverflow,
              shadows: shadows,
              textBaseline: textBaseline,
            );
      case TextType.caption:
        return Theme.of(context).textTheme.caption!.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              decoration: decoration,
              fontSize: responsiveFontSize(
                  context,
                  fontSize ?? Theme.of(context).textTheme.caption!.fontSize,
                  minFontSize,
                  maxFontSize),
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              overflow: textOverflow,
              shadows: shadows,
              textBaseline: textBaseline,
            );
      case TextType.overline:
        return Theme.of(context).textTheme.overline!.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              decoration: decoration,
              fontSize: responsiveFontSize(
                  context,
                  fontSize ?? Theme.of(context).textTheme.overline!.fontSize,
                  minFontSize,
                  maxFontSize),
              fontStyle: fontStyle,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              wordSpacing: wordSpacing,
              overflow: textOverflow,
              shadows: shadows,
              textBaseline: textBaseline,
            );
    }
  }

  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 2400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }

  static double responsiveFontSize(
      BuildContext context, double? constText, double? min, double? max) {
    //Important: to test text size => change ratioText
    double value =
        constText! * (MediaQuery.of(context).size.width / ratioText) / 100;

    // if (min != null && max != null) {
    //   value.clamp(min, max);
    // } else if (min != null) {
    //   value.clamp(min, constText);
    // } else if (max != null) {
    //   value.clamp(10, max);
    // }

    print('textTest_$value');
    print('constText_$constText');

    if (value > constText + 13) {
      return constText;
    } else if (value < 12) {
      return value + MediaQuery.of(context).size.width / 45;
    } else {
      return value;
    }
  }
}

enum TextType {
  header1,
  header2,
  header3,
  header4,
  header5,
  header6,
  subtitle1,
  subtitle2,
  body1,
  body2,
  button,
  caption,
  overline
}
