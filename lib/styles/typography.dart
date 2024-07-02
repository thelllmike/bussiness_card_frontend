import 'package:flutter/material.dart';

class AppTypography {
  static const String fontFamily = 'GeneralSans';

  static const TextStyle businessCardTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.35, // This is line-height / font-size
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle businessCardSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.35, // This is line-height / font-size
    color: Color(0xFF0B2A47),
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.35, // This is line-height / font-size
    color: Colors.white,
    textBaseline: TextBaseline.alphabetic,
  );
}
