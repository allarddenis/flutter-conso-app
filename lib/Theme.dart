import 'package:flutter/material.dart';

class Colors {

  const Colors();

  static const Color homeAppBarTitleColor = const Color(0xFF5D4037);
  static const Color appBarIconColor = const Color(0xFFEFEBE9);
  static const Color homeAppBarGradientStart = const Color(0xFFEFEBE9);
  static const Color homeAppBarGradientEnd = const Color(0xFFD7CCC8);
  static const Color homeBackgroundGradientStart = const Color(0xFFD7CCC8);
  static const Color homeBackgroundGradientEnd = const Color(0xFFBCAAA4);

  static const Color homeItemTextColor = const Color(0xFFEFEBE9);
  static const homeItemTextDecorationColor = const Color(0x000000);
  static const List<Color> homeItemBackgroundColors = const [
    const Color(0xFF3E2723),
    const Color(0xFF3E2723),
    const Color(0xFF3E2723)
  ];

}

class TextStyles {

  const TextStyles();

  static const TextStyle homeItemStyle = const TextStyle(
    color: Colors.homeItemTextColor,
    fontFamily: 'Pacifico',
    fontSize: 36.0,
  );

  static const TextStyle homeAppBarStyle = const TextStyle(
    color: Colors.homeAppBarTitleColor,
    fontFamily: 'Pacifico',
    fontWeight: FontWeight.w700,
    fontSize: 40.0,
  );

}