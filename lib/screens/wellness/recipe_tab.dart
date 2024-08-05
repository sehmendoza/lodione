import 'package:flutter/material.dart';
import 'package:lodione/models/list_model.dart';

import '../../models/recipe_model.dart';

class RecipeTab extends StatefulWidget {
  const RecipeTab({super.key});

  @override
  State<RecipeTab> createState() => _RecipeTabState();
}

class _RecipeTabState extends State<RecipeTab> {
  List<RecipeModel> recipes = [
    RecipeModel(name: 'Goto', ingredients: [
      ListItem(
        id: '34',
        name: 'name',
        isDone: false,
      ),
      ListItem(
        id: '3',
        name: 'fff',
        isDone: false,
      ),
      ListItem(
        id: '22',
        name: 'gfg',
        isDone: false,
      ),
    ], steps: [])
  ];

  void addNewRecipe() {
    TextEditingController nameController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.black,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(width: 2, color: Colors.white),
              ),
              title: const Text(
                'Add New List',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    maxLines: 1,
                    maxLength: 24,
                    style: const TextStyle(color: Colors.white),
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'List Name',
                      hintStyle: TextStyle(color: Colors.white54),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        recipes.add(RecipeModel(
                            name: nameController.text,
                            ingredients: [],
                            steps: []));
                      });

                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
          padding: EdgeInsets.only(left: 8, bottom: 8),
          child: Row(
            children: [
              Text(
                'Recipes:',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              var recipe = recipes[index];
              String ingredients = recipe.ingredients
                  .map((item) => item.name)
                  .toList()
                  .join(', ');
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton.icon(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            style: OutlinedButton.styleFrom(
              fixedSize: const Size(150, 30),
              side: const BorderSide(
                color: Colors.white,
                width: 3,
              ),
            ),
            onPressed: addNewRecipe,
            label: const Text(
              'Add Recipe',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
