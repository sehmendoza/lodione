import 'package:flutter/material.dart';

import '../../../models/recipe_model.dart';
import 'recipe_overview.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({super.key, required this.recipes});

  final List<RecipeModel> recipes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          var recipe = recipes[index];
          String ingredients =
              recipe.ingredients.map((item) => item.name).toList().join(', ');
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeOverview(
                    recipe: recipe,
                  ),
                ),
              ),
              // leading: Icon(
              //   categoryIcon[recipe.foodCategory]!,
              //   color: Colors.white70,
              // ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white70,
              ),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(
                  color: Colors.white,
                ),
              ),
              title: Text(
                recipe.name,
                style: const TextStyle(color: Colors.white, fontSize: 21),
              ),
              subtitle: Text(
                ingredients,
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
