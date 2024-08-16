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
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 13, bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      recipeList = recipes
                          .where((element) => element.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  controller: searchController,
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
              const SizedBox(width: 10),
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
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              MyChipFilter(
                  icon: Icons.food_bank_rounded,
                  label: 'All',
                  onSelected: (bool value) {
                    setState(() {
                      recipeList = recipes;
                    });
                  }),
              MyChipFilter(
                  icon: categoryIcon[FoodCategory.breakfast]!,
                  label: 'Breakfast',
                  onSelected: (bool value) {
                    setState(() {
                      recipeList = recipes
                          .where((element) =>
                              element.foodCategory == FoodCategory.breakfast)
                          .toList();
                    });
                  }),
              MyChipFilter(
                  icon: categoryIcon[FoodCategory.lunch]!,
                  label: 'Lunch',
                  onSelected: (bool value) {
                    setState(() {
                      recipeList = recipes
                          .where((element) =>
                              element.foodCategory == FoodCategory.lunch)
                          .toList();
                    });
                  }),
              MyChipFilter(
                  icon: categoryIcon[FoodCategory.dinner]!,
                  label: 'Dinner',
                  onSelected: (bool value) {
                    setState(() {
                      recipeList = recipes
                          .where((element) =>
                              element.foodCategory == FoodCategory.dinner)
                          .toList();
                    });
                  }),
              MyChipFilter(
                  icon: categoryIcon[FoodCategory.snacks]!,
                  label: 'Snacks',
                  onSelected: (bool value) {
                    setState(() {
                      recipeList = recipes
                          .where((element) =>
                              element.foodCategory == FoodCategory.snacks)
                          .toList();
                    });
                  },),
              MyChipFilter(
                icon: categoryIcon[FoodCategory.desserts]!,
                label: 'Desserts',
                onSelected: (bool value) {
                  setState(() {
                    recipeList = recipes
                        .where((element) =>
                            element.foodCategory == FoodCategory.desserts)
                        .toList();
                  });
                },
              ),
              MyChipFilter(
                  icon: categoryIcon[FoodCategory.others]!,
                  label: 'Others',
                  onSelected: (bool value) {
                    setState(() {
                      recipeList = recipes
                          .where((element) =>
                              element.foodCategory == FoodCategory.others)
                          .toList();
                    });
                  })
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(child: RecipeList(recipes: recipeList)),
      ],
    );
  }
}

class MyChipFilter extends StatefulWidget {
  const MyChipFilter({
    super.key,
    required this.onSelected,
    required this.icon,
    required this.label,
  });

  final Function(bool)? onSelected;
  final IconData icon;
  final String label;
  @override
  State<MyChipFilter> createState() => _MyChipFilterState();
}

class _MyChipFilterState extends State<MyChipFilter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        selectedColor: Colors.white,
        backgroundColor: Colors.black,
        deleteIcon: const Icon(Icons.close, color: Colors.white70),
        label: Text(
          widget.label,
          style: const TextStyle(color: Colors.white70),
        ),
        onSelected: widget.onSelected,
        avatar: Icon(widget.icon, color: Colors.white70),
        avatarBorder: const CircleBorder(
          side: BorderSide(color: Colors.white70),
        ),
      ),
    );
  }
}
