import 'package:flutter/material.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Category:', style: TextStyle(color: Colors.white)),
                const SizedBox(width: 10),
                Icon(
                  categoryIcon[recipe.foodCategory],
                  color: Colors.white,
                ),
                const SizedBox(width: 6),
                Text(
                    recipe.foodCategory.name[0].toUpperCase() +
                        recipe.foodCategory.name.substring(1),
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Ingredients:',
              style: TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: recipe.ingredients.length,
                    itemBuilder: (context, index) {
                      var ingredient = recipe.ingredients[index].name;
                      return Row(
                        children: [
                          Text(
                            '\u2022  $ingredient',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
            const Text(
              'Direction:',
              style: TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (final step in recipe.steps)
                      ListTile(
                        key: ValueKey(step),
                        leading: Text(
                          '${recipe.steps.indexOf(step) + 1}.',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 21),
                        ),
                        title: Text(
                          step,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 21),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
