import 'package:flutter/material.dart';
import 'package:lodione/widgets/buttons.dart';

import '../../../models/recipe_model.dart';
import '../../../storage/recipe_list.dart';
import 'new_recipe.dart';
import 'recipe_list.dart';

class RecipeTab extends StatefulWidget {
  const RecipeTab({super.key});

  @override
  State<RecipeTab> createState() => _RecipeTabState();
}

class _RecipeTabState extends State<RecipeTab> {
  List<RecipeModel> recipeList = recipes;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white70,
                    ),
                    hintText: 'Search recipe',
                    hintStyle: const TextStyle(
                      color: Colors.white38,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 15),
          child: Row(
            children: [
              Text(
                'Recipes:',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(child: RecipeList(recipes: recipeList)),
        MyButton(
            text: 'Add recipe',
            icon: Icons.add,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewRecipe(),
                ),
              );
            }),
      ],
    );
  }
}
