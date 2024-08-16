import 'package:flutter/material.dart';

const black = Color(0xFF000000);
const white = Color(0xFFFFFFFF);

// Define the button style
ButtonStyle myButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all(black),
  foregroundColor: WidgetStateProperty.all(white),
  shape: WidgetStateProperty.all(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  )),
  elevation: WidgetStateProperty.all(0),
);

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.black);

final myTheme = ThemeData().copyWith(
  colorScheme: kColorScheme,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme().copyWith(
    foregroundColor: kColorScheme.primaryContainer,
    backgroundColor: Colors.black,
    elevation: 0,
    centerTitle: true,
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.all(Colors.black),
    checkColor: WidgetStateProperty.all(Colors.white),
  ),
);
