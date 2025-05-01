import 'package:flutter/material.dart';

PalletColors palletColors = PalletColors();
Color seedColor = hexToColor("F3EBF3");
Color secondaryColor = hexToColor("A081A0");
Color lightSeedColor = const Color.fromARGB(255, 38, 22, 52);
Color containerBackground = const Color.fromARGB(255, 38, 22, 52);
Color imperialPurple = const Color.fromARGB(255, 93, 58, 106); // Hex: #5D3A6A
Color badgeOutline = Colors.purple.shade200;
Color cyanPrimary = const Color.fromRGBO(0, 191, 255, 1.0); // HEX: #00BFFF
Color yellowPrimary = const Color.fromRGBO(255, 215, 0, 1.0);
Color magentaPrimary = const Color.fromRGBO(255, 0, 255, 1.0); // HEX: #FF00FF

Color neonGreen = const Color.fromARGB(255, 180, 255, 105);
Color neonBlue = const Color.fromARGB(255, 105, 255, 255); // Hex: #69FFFF
Color websitePurple = const Color(0xFFCE93D8);

Color listTileBackground = const Color.fromARGB(255, 206, 203, 210);
Color titleText = seedColor;
Color subtitleText = seedColor.withAlpha(175);

Color drawerBackground = Colors.black;

// Hex: #B4FF69
Color expansionPanelBackground = const Color.fromARGB(255, 38, 22, 52);

Color deleteRed = hexToColor("A34242");
Color archieveGreen = hexToColor("8A9A5B");

class PalletColors {
  PalletColor pink = PalletColor(
      colorIndex: 0,
      name: "Blush Pink",
      primary: hexToColor("A38384")); // Blush Pink
  PalletColor terracotta = PalletColor(
      colorIndex: 1,
      name: "Terracotta",
      primary: hexToColor("D16E66")); // Terracotta
  PalletColor peach = PalletColor(
      colorIndex: 2, name: "Burnt Peach", primary: hexToColor("B97E4C")); //
  PalletColor sandstone = PalletColor(
      colorIndex: 3, name: "Sandstone", primary: hexToColor("A08674")); //
  PalletColor dustyBlue = PalletColor(
      colorIndex: 4, name: "Dusty Blue", primary: hexToColor("778F98"));
  PalletColor oliveGreen = PalletColor(
      colorIndex: 5, name: "Olive Green", primary: hexToColor("8A9A5B"));
  PalletColor lilac = PalletColor(
      colorIndex: 6, name: "Muted Lilac", primary: hexToColor("A081A0"));
  PalletColor goldenAmber = PalletColor(
      colorIndex: 7,
      name: "Golden Amber",
      primary: hexToColor("B5883E")); // Golden Amber
  PalletColor deepCarmine = PalletColor(
      colorIndex: 8,
      name: "Deep Carmine",
      primary: hexToColor("A34242")); // Deep Carmine
  PalletColor warmBeige = PalletColor(
      colorIndex: 9,
      name: "Warm Beige",
      primary: hexToColor("C4A58A")); // Warm Beige
  PalletColor softPlum = PalletColor(
      colorIndex: 10,
      name: "Soft Plum",
      primary: hexToColor("7F5D72")); // Soft Plum
  PalletColor paleMint = PalletColor(
      colorIndex: 11, name: "Mint", primary: hexToColor("7E9F8C")); // Pale Mint
  PalletColor deepOrange = PalletColor(
      colorIndex: 12, name: "Deep Orange", primary: const Color(0xFFD84315));
  PalletColor crimsonRed = PalletColor(
      colorIndex: 13, name: "Crimson Red", primary: const Color(0xFFC62828));
  PalletColor electricBlue = PalletColor(
      colorIndex: 14, name: "Electric Blue", primary: const Color(0xFF2962FF));
  PalletColor royalPurple = PalletColor(
      colorIndex: 15, name: "Royal Purple", primary: const Color(0xFF6200EA));
  PalletColor forestGreen = PalletColor(
      colorIndex: 16, name: "Forest Green", primary: const Color(0xFF1B5E20));
  PalletColor teal = PalletColor(
      colorIndex: 17, name: "Teal", primary: const Color(0xFF00897B));
  PalletColor goldenYellow = PalletColor(
      colorIndex: 18, name: "Golden Yellow", primary: const Color(0xFFF9A825));
  PalletColor burntSienna = PalletColor(
      colorIndex: 19, name: "Burnt Sienna", primary: const Color(0xFF8D4F25));
  PalletColor midnightNavy = PalletColor(
      colorIndex: 20, name: "Midnight Navy", primary: const Color(0xFF1A237E));
  PalletColor fuchsia = PalletColor(
      colorIndex: 21, name: "Fuchsia", primary: const Color(0xFFD500F9));
  PalletColor darkCyan = PalletColor(
      colorIndex: 22, name: "Dark Cyan", primary: const Color(0xFF006064));
  PalletColor graphiteGray = PalletColor(
      colorIndex: 23, name: "Graphite Gray", primary: const Color(0xFF424242));

  List<PalletColor> get colors => [
        pink,
        terracotta,
        peach,
        sandstone,
        dustyBlue,
        oliveGreen,
        lilac,
        goldenAmber,
        deepCarmine,
        warmBeige,
        softPlum,
        paleMint,
        deepOrange,
        crimsonRed,
        electricBlue,
        royalPurple,
        forestGreen,
        teal,
        goldenYellow,
        burntSienna,
        midnightNavy,
        fuchsia,
        darkCyan,
        graphiteGray
      ];

  getPalletColorByIndex(int index) {
    switch (index) {
      case 0:
        return pink;
      case 1:
        return terracotta;
      case 2:
        return peach;
      case 3:
        return sandstone;
      case 4:
        return dustyBlue;
      case 5:
        return oliveGreen;
      case 6:
        return lilac;
      case 7:
        return goldenAmber;
      case 8:
        return deepCarmine;
      case 9:
        return warmBeige;
      case 10:
        return softPlum;
      case 11:
        return paleMint;
      case 12:
        return deepOrange;
      case 13:
        return crimsonRed;
      case 14:
        return electricBlue;
      case 15:
        return royalPurple;
      case 16:
        return forestGreen;
      case 17:
        return teal;
      case 18:
        return goldenYellow;
      case 19:
        return burntSienna;
      case 20:
        return midnightNavy;
      case 21:
        return fuchsia;
      case 22:
        return darkCyan;
      case 23:
        return graphiteGray;
      default:
        return pink;
    }
  }
}

class PalletColor {
  int colorIndex;
  final String name;
  Color primary;

  PalletColor(
      {required this.colorIndex, required this.name, required this.primary});
}

Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
