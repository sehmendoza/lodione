import 'package:flutter/material.dart';
import 'screens/main/start_screen.dart';

void main() {
  runApp(const StartUp());
}

class StartUp extends StatelessWidget {
  const StartUp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}
