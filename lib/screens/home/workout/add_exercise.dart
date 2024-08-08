import 'package:flutter/material.dart';

class AddExercise extends StatelessWidget {
  const AddExercise({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Add exercise'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: const Column(
        children: [
          Text('Exercise name:'),
          TextField(
            decoration: InputDecoration(enabledBorder: OutlineInputBorder()),
          )
        ],
      ),
    );
  }
}
