import 'package:flutter/material.dart';
import 'package:lodione/widgets/buttons.dart';

import '../../../models/list_model.dart';
import '../../../models/recipe_model.dart';

class RecipeOverview extends StatelessWidget {
  const RecipeOverview({required this.recipe, super.key});
  final RecipeModel recipe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You selected: $result')),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Option 1',
                child: Text('Edit'),
              ),
              const PopupMenuItem<String>(
                value: 'Option 2',
                child: Text('Share'),
              ),
              PopupMenuItem<String>(
                value: 'Option 3',
                child: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Category:',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      categoryIcon[recipe.foodCategory],
                      color: Colors.white,
                      size: 26,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      recipe.foodCategory.name[0].toUpperCase() +
                          recipe.foodCategory.name.substring(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Ingredients:',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    MyButton(text: 'Add', icon: Icons.add, onPressed: () {})
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (ListItem ing in recipe.ingredients)
                        Text(
                          '• ${ing.name}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Direction',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final step in recipe.steps)
                        Text(
                          '${recipe.steps.indexOf(step) + 1}. $step',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 21),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
