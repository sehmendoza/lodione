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
  List<RecipeModel> favoriteList =
      recipes.where((fav) => fav.isFavorite).toList();
  TextEditingController searchController = TextEditingController();
  FoodCategory? _selectedCategory;

  void toggleFavorite(RecipeModel recipe) {
    bool isExist = favoriteList.contains(recipe);

    if (isExist) {
      favoriteList.remove(recipe);
    } else {
      favoriteList.add(recipe);
    }
  }

  void toggleFavChip() {
    setState(() {
      favoriteToggle = !favoriteToggle;
      recipeList = favoriteToggle
          ? _selectedCategory == null
              ? recipes.where((fav) => fav.isFavorite).toList()
              : favoriteList
                  .where((cat) => cat.foodCategory == _selectedCategory)
                  .toList()
          : _selectedCategory == null
              ? recipes
              : recipes
                  .where((cat) => cat.foodCategory == _selectedCategory)
                  .toList();
    });
  }

  bool favoriteToggle = false;

  void toggleChip(FoodCategory category) {
    setState(() {
      // If the same category is clicked again, deselect it
      if (_selectedCategory == category) {
        _selectedCategory = null;
        recipeList = favoriteToggle
            ? recipes.where((fav) => fav.isFavorite).toList()
            : recipes; // Show all recipes
      } else {
        _selectedCategory = category;
        recipeList = recipes
            .where((element) => element.foodCategory == category)
            .toList();
        recipeList = favoriteToggle
            ? recipeList.where((fav) => fav.isFavorite).toList()
            : recipeList;
      }
    });
  }

  void _searching(text) {
    setState(() {
      searchController.text.isEmpty
          ? _selectedCategory == null
              ? recipeList = recipes
              : recipeList = recipes
                  .where((recipe) => recipe.foodCategory == _selectedCategory)
                  .toList()
          : recipeList = recipeList
              .where((element) =>
                  element.name.toLowerCase().contains(text.toLowerCase()))
              .toList();
    });
  }

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
                    _searching(value);
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyChipFilter(
                selected: _selectedCategory ==
                    null, // 'All' is selected when no category is
                icon: Icons.food_bank_rounded,
                label: 'All',
                onSelected: (bool value) {
                  setState(() {
                    _selectedCategory = null;
                    recipeList = favoriteToggle
                        ? recipes.where((fav) => fav.isFavorite).toList()
                        : recipes; // Show all recipes
                  });
                },
              ),
              MyChipFilter(
                  onSelected: (value) {
                    toggleFavChip();
                  },
                  icon: favoriteToggle ? Icons.favorite : Icons.favorite_border,
                  label: 'Favorite',
                  selected: favoriteToggle),
              MyChipFilter(
                selected: _selectedCategory == FoodCategory.breakfast,
                icon: categoryIcon[FoodCategory.breakfast]!,
                label: 'Breakfast',
                onSelected: (bool value) => toggleChip(FoodCategory.breakfast),
              ),
              MyChipFilter(
                selected: _selectedCategory == FoodCategory.lunch,
                icon: categoryIcon[FoodCategory.lunch]!,
                label: 'Lunch',
                onSelected: (bool value) => toggleChip(FoodCategory.lunch),
              ),
              MyChipFilter(
                selected: _selectedCategory == FoodCategory.dinner,
                icon: categoryIcon[FoodCategory.dinner]!,
                label: 'Dinner',
                onSelected: (bool value) => toggleChip(FoodCategory.dinner),
              ),
              MyChipFilter(
                selected: _selectedCategory == FoodCategory.treats,
                icon: categoryIcon[FoodCategory.treats]!,
                label: 'Treats',
                onSelected: (bool value) => toggleChip(FoodCategory.treats),
              ),
              MyChipFilter(
                selected: _selectedCategory == FoodCategory.others,
                icon: categoryIcon[FoodCategory.others]!,
                label: 'Others',
                onSelected: (bool value) => toggleChip(FoodCategory.others),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: RecipeList(recipes: recipeList, onFavorite: toggleFavorite),
        ),
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
    required this.selected,
  });

  final Function(bool)? onSelected;
  final IconData icon;
  final String label;
  final bool selected;
  @override
  State<MyChipFilter> createState() => _MyChipFilterState();
}

class _MyChipFilterState extends State<MyChipFilter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        selectedColor: const Color.fromARGB(190, 0, 0, 0),
        shadowColor: Colors.white,
        elevation: widget.selected ? 1 : 3,
        side: BorderSide(
            color: widget.selected ? Colors.white : Colors.white70, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        showCheckmark: false,
        backgroundColor: Colors.black,
        label: Text(
          widget.label,
          style: TextStyle(
            color: widget.selected ? Colors.white : Colors.white70,
          ),
        ),
        selected: widget.selected,
        onSelected: widget.onSelected,
        avatar: Icon(widget.icon,
            color: widget.selected ? Colors.white : Colors.white70),
      ),
    );
  }
}
