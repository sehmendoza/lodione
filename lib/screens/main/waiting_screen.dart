import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Circular Progress Indicator
            CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.0,
            ),
            SizedBox(height: 20), // Spacing between loader and text
            // Text below the loader
            Text(
              'Please wait...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
