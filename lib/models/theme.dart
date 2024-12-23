import 'package:flutter/material.dart';

class AppTheme {

  static const EdgeInsets allPadding = EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 0);
  static const EdgeInsets secondPadding = EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0);

  static const Color primaryBackgroundColor = Color.fromRGBO(255, 248, 240, 1.0);
  static const Color secondaryBackgroundColor = Color.fromRGBO(244, 208, 111, 1.0);

  static const Color textColor = Color.fromRGBO(57, 47, 90, 1.0);

  static const String fontFamily = 'Inter';

  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 40,
    color: textColor,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 30,
    color: textColor,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: textColor,
  );

  static const TextStyle heading3DiffColor = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: Color(0xFFFFFFFF),
  );

  static const TextStyle heading4 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: textColor,
  );

  static const TextStyle heading5 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w900,
    fontSize: 16,
    color: textColor,
  );

  static const TextStyle heading6 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: textColor,
    fontStyle: FontStyle.italic,
  );

}