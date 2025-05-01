import 'package:flutter/material.dart';
import 'package:opper/design/colors.dart';

ThemeData opperTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark, // Ensure brightness matches
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all<double>(25.0),
      backgroundColor:
          WidgetStateProperty.all<Color>(websitePurple.withAlpha(180)),
      foregroundColor: WidgetStateProperty.all<Color>(seedColor),
      padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0)),
      textStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    ),
  ),
);
