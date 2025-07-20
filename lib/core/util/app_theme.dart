import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const blue10 = Color.fromRGBO(242, 249, 249, 1);
  static const blue20 = Color.fromRGBO(158, 200, 225, 1.0);
  static const blue30 = Color.fromRGBO(110, 173, 213, 1.0);
  static const blue40 = Color.fromRGBO(62, 146, 199, 1.0);
  static const blue50 = Color.fromRGBO(0, 112, 181, 1);
  static const blue60 = Color.fromRGBO(23, 99, 150, 1.0);
  static const blue70 = Color.fromRGBO(18, 77, 116, 1.0);
  static const blue80 = Color.fromRGBO(15, 57, 82, 1.0);
  static const blue90 = Color.fromRGBO(12, 36, 48, 1.0);

  static const black10 = Color.fromRGBO(246, 246, 246, 1.0);
  static const black20 = Color.fromRGBO(225, 224, 225, 1.0);
  static const black30 = Color.fromRGBO(192, 192, 192, 1.0);
  static const black40 = Color.fromRGBO(158, 158, 158, 1.0);
  static const black60 = Color.fromRGBO(109, 109, 109, 1.0);

  static const green60 = Color.fromRGBO(140, 165, 80, 1.0);

  static const red40 = Color.fromRGBO(199, 68, 76, 1.0);
  static const rubyLight = Color.fromRGBO(239, 225, 226, 1.0);
  static const ruby = Color.fromRGBO(198, 52, 54, 1.0);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFC0C0C0);
  static const Color greyLight = Color(0xFFE0E0E0);
  static const Color green = Color(0xFF00CE50);

  static const Gradient gradientViolet = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.centerRight,
    colors: [Color.fromRGBO(55, 213, 239, 1), Color.fromRGBO(84, 82, 254, 1)],
  );

  static const Gradient gradientBlue = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color.fromRGBO(55, 213, 239, 1), Color.fromRGBO(35, 64, 209, 1)],
  );

  static const Gradient gradientBlue2 = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [Color.fromRGBO(55, 213, 239, 1), Color.fromRGBO(35, 64, 209, 1)],
  );

  static const Gradient gradientBlue3 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromRGBO(153, 198, 225, 1), Color.fromRGBO(0, 112, 181, 1)],
  );

  static const Gradient gradientGrey = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color.fromRGBO(255, 255, 255, 1.0),
      Color.fromRGBO(224, 224, 224, 1.0)
    ],
  );

  static const Gradient gradientGiro = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color.fromRGBO(76, 149, 194, 1),
      Color.fromRGBO(20, 103, 155, 1),
    ],
  );

  static const Gradient gradientDeposito = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color.fromRGBO(49, 176, 255, 1),
      Color.fromRGBO(16, 131, 202, 1),
    ],
  );

  static const Gradient gradientPocket = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color.fromRGBO(150, 201, 61, 1),
      Color.fromRGBO(0, 176, 155, 1),
    ],
  );

  static List<BoxShadow> boxShadow = [
    const BoxShadow(
      color: AppTheme.black20,
      offset: Offset(0, -2),
      spreadRadius: 0.1,
      blurRadius: 3,
    )
  ];

  static List<BoxShadow> boxShadow2 = [
    const BoxShadow(
      color: AppTheme.black20,
      offset: Offset(0, 4),
      spreadRadius: 0,
      blurRadius: 12,
    )
  ];

  static const String fontName = 'Poppins';

  static TextStyle title({
    Color? color = black,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w600,
        fontSize: 19,
        color: color,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle subtitle1({
    Color? color = black,
    double? height,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w600,
        fontSize: 15,
        color: color,
        height: height,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle subtitle2({
    Color? color = black,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: color,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle subtitle3({
    Color? color = black,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: color,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle body1({
    Color? color = black,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: color,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle body2({
    Color? color = black,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: color,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle body3({
    Color? color = black,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: 12,
        color: color,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle button({
    Color? color = white,
    double? size = 16,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w700,
        fontSize: size,
        color: color,
        decoration: decoration,
        fontStyle: fontStyle,
      );

  static TextStyle dataValue({
    Color? color = black,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: color,
        fontStyle: fontStyle,
      );

  static TextStyle caption({
    Color? color = black,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontName,
        fontWeight: FontWeight.w400,
        fontSize: 10,
        decoration: decoration,
        color: color,
        fontStyle: fontStyle,
      );

  static TextStyle custom(
          {String? fontName = fontName,
          FontWeight? weight = FontWeight.w500,
          double? size = 16,
          double? letterSpacing,
          Color? color,
          TextDecoration? decoration,
          FontStyle? fontstyle}) =>
      TextStyle(
        fontStyle: fontstyle,
        fontFamily: fontName,
        fontWeight: weight,
        fontSize: size,
        letterSpacing: letterSpacing,
        color: color,
        decoration: decoration,
      );
}
