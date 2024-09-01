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

InputDecoration myTextfieldDeco(label) {
  return InputDecoration(
    label: Text(
      label,
      style: TextStyle(color: Colors.white.withAlpha(200)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 109, 17, 11), width: 1),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 109, 17, 11), width: 2),
    ),
  );
}

Widget myButton1(name, onPressed) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      fixedSize: const Size(200, 40),
    ),
    onPressed: onPressed,
    child: Text(
      name,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.black, letterSpacing: 2, fontWeight: FontWeight.bold),
    ),
  );
}

Widget myButton2(name, onPressed) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shadowColor: Colors.white,
      elevation: 5,
      fixedSize: const Size(200, 40),
      backgroundColor: Colors.black,
      side: const BorderSide(color: Colors.white, width: 2),
    ),
    onPressed: onPressed,
    child: Text(
      name,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, letterSpacing: 2),
    ),
  );
}
