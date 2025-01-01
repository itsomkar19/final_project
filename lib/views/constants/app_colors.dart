import 'package:flutter/material.dart';

@immutable
class AppColors {
  static const blueRibbon =
      Color.fromARGB(255, 49, 64, 247); // '#3140F7'.asHtmlColorToColor()
  static const mauve =
      Color.fromARGB(255, 209, 169, 251); // '#D1A9FB'.asHtmlColorToColor()
  static const cornflowerBlue =
      Color.fromARGB(255, 128, 109, 251); // '#806DFB'.asHtmlColorToColor()
  static const malibu =
      Color.fromARGB(255, 146, 168, 252); // '#92A8FC'.asHtmlColorToColor()

  static const welcomeButtonColor = mauve;
  static const welcomeButtonShadowColor = Color.fromARGB(255, 56, 55, 55);

  static const welcomeLinearGradientColors = [
    Color.fromARGB(255, 231, 209, 255),
    Color.fromARGB(255, 255, 255, 255),
  ];

  static const urlColor = blueRibbon;

  const AppColors._();
}
