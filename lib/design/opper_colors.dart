import 'dart:ui';

class OpperColors {
  static const Color purple = Color.fromARGB(255, 90, 51, 104);
  static const Color unselected = Color.fromARGB(255, 41, 39, 41);
  static const Color seedColor = Color.fromRGBO(251, 227, 255, 1);
  static const Color secondaryBackground = Color.fromARGB(255, 49, 49, 49);
}

class AlignColors {
  static const Color color1 = Color(0xFFFF0000); // Red
  static const Color color2 = Color(0xFF00FF00); // Green
  static const Color color3 = Color(0xFF0000FF); // Blue
  static const Color color4 = Color(0xFFFFFF00); // Yellow
  static const Color color5 = Color(0xFFFF00FF); // Magenta
  static const Color color6 = Color(0xFF00FFFF); // Cyan
  static const Color color7 = Color(0xFFFFA500); // Orange
  static const Color color8 = Color(0xFF800080); // Purple
  static const Color color9 = Color(0xFF808000); // Olive
  static const Color color10 = Color(0xFF008080); // Teal
  static const Color color11 = Color(0xFFFFC0CB); // Pink (replacing Maroon)
  static const Color color12 = Color(0xFFADD8E6); // LightBlue (replacing Navy)
  static const Color color13 = Color(0xFFB0E0E6); // PowderBlue
  static const Color color14 = Color(0xFFFA8072); // Salmon
  static const Color color15 = Color(0xFFF4A460); // SandyBrown
  static const Color color16 =
      Color(0xFFAFEEEE); // PaleTurquoise (replacing CadetBlue)
  static const Color color17 = Color(0xFF7FFF00); // Chartreuse
  static const Color color18 = Color(0xFFD2691E); // Chocolate
  static const Color color19 = Color(0xFF6495ED); // CornflowerBlue
  static const Color color20 = Color(0xFFDC143C); // Crimson
  static const Color color21 = Color(0xFF00CED1); // DarkTurquoise
  static const Color color22 = Color(0xFF9400D3); // DarkViolet
  static const Color color23 = Color(0xFFFF1493); // DeepPink
  static const Color color24 = Color(0xFF00BFFF); // DeepSkyBlue
  static const Color color25 = Color(0xFFF5F5DC); // Beige (replacing DimGray)
  static const Color color26 = Color(0xFF1E90FF); // DodgerBlue
  static const Color color27 =
      Color(0xFFFFFACD); // LemonChiffon (replacing DarkGoldenRod)
  static const Color color28 = Color(0xFFADFF2F); // GreenYellow
  static const Color color29 = Color(0xFFE6E6FA); // Lavender (replacing Indigo)
  static const Color color30 = Color(0xFFFFE4B5); // Moccasin

  static Color? getColorByIndex(int index) {
    index = (index % 30) + 1; // Loop back to the first index if greater than 29
    final colors = [
      color1,
      color2,
      color3,
      color4,
      color5,
      color6,
      color7,
      color8,
      color9,
      color10,
      color11,
      color12,
      color13,
      color14,
      color15,
      color16,
      color17,
      color18,
      color19,
      color20,
      color21,
      color22,
      color23,
      color24,
      color25,
      color26,
      color27,
      color28,
      color29,
      color30,
    ];
    return colors[index - 1];
  }
}
