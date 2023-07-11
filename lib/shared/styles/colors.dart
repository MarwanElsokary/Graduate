import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
HexColor defaultcol =HexColor('#87B4C6');
class cc {
  static const MaterialColor defcol = const MaterialColor(
    0xff87b4c6, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff7aa2b2 ),//10%
      100: const Color(0xff6c909e),//20%
      200: const Color(0xff5f7e8b),//30%
      300: const Color(0xff516c77),//40%
      400: const Color(0xff445a63),//50%
      500: const Color(0xff36484f),//60%
      600: const Color(0xff28363b),//70%
      700: const Color(0xff1b2428),//80%
      800: const Color(0xff0d1214),//90%
      900: const Color(0xff000000),//100%
    },
  );
}