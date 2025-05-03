import 'dart:ui';

class OpperColors {
  static const Color purple = Color.fromARGB(255, 90, 51, 104);
  static const Color unselected = Color.fromARGB(255, 41, 39, 41);
  static const Color seedColor = Color.fromRGBO(251, 227, 255, 1);
  static const Color secondaryBackground = Color.fromARGB(255, 49, 49, 49);
}

class PrimaryColors {
  static const Color red = Color(0xFFFF0000); // Red
  static const Color green = Color(0xFF00FF00); // Green
  static const Color blue = Color(0xFF0000FF); // Blue
  static const Color yellow = Color(0xFFFFFF00); // Yellow
  static const Color magenta = Color(0xFFFF00FF); // Magenta
  static const Color cyan = Color(0xFF00FFFF); // Cyan
}

class AlignColors {
  static const Color color0 = Color.fromRGBO(251, 227, 255, 1);
  static const Color color1 = Color.fromARGB(255, 175, 74, 73);
  static const Color color2 = Color.fromARGB(255, 123, 169, 120);
  static const Color color3 = Color.fromARGB(255, 233, 200, 71);
  static const Color color4 = Color.fromARGB(255, 80, 120, 180);
  static const Color color5 = Color.fromARGB(255, 150, 90, 160);
  static const Color color6 = Color.fromARGB(255, 220, 130, 60);
  static const Color color7 = Color.fromARGB(255, 70, 160, 170);
  static const Color color8 = Color.fromARGB(255, 200, 100, 150);
  static const Color color9 = Color.fromARGB(255, 180, 170, 150);

  // Updated list containing all 9 colors
  static final List<Color> _allColors = [
    color1,
    color2,
    color3,
    color4,
    color5,
    color6,
    color7,
    color8,
    color9,
  ];

  // --- Updated getColorByIndex Method ---
  // Assumes index starts from 0. If your index starts from 1, use (index - 1) % _allColors.length
  static Color getColorByIndex(int index) {
    // Use modulo to loop back within the range of available colors (0 to 8 for 9 colors)
    final int actualIndex = index % _allColors.length;
    return _allColors[actualIndex];
  }
}
