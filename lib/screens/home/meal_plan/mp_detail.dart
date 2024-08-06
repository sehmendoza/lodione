import 'package:flutter/material.dart';

class MealPlanDetail extends StatelessWidget {
  MealPlanDetail({required this.day, required this.mealType, super.key});
  final String day;
  final String mealType;

  final List<String> meals = [
    'Adobo Chicken',
    'Sinigang na Baboy',
    'Spaghetti',
    'Coke',
    'Cookies',
    'Coffee'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('$day - $mealType'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select meal:',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            ...meals.map((meal) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(color: Colors.white, width: 2)),
                    title: Text(
                      meal,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
