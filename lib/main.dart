import 'package:flutter/material.dart';
import 'screens/main/start_screen.dart';

void main() {
  runApp(const StartUp());
}

class StartUp extends StatelessWidget {
  const StartUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.all(Colors.black),
          checkColor: WidgetStateProperty.all(Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const StartScreen(),
    );
  }
}
