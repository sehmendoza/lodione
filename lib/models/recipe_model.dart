import 'list_model.dart';
import 'package:flutter/material.dart';

enum FoodCategory { breakfast, lunch, dinner, treats, drinks, others }

const categoryIcon = {
  FoodCategory.breakfast: Icons.wb_sunny,
  FoodCategory.lunch: Icons.lunch_dining,
  FoodCategory.dinner: Icons.dinner_dining,
  FoodCategory.treats: Icons.cookie,
  FoodCategory.drinks: Icons.local_drink,
  FoodCategory.others: Icons.fastfood,
};

class RecipeModel {
  String name;
  List<ListItem> ingredients;
  List<String> steps;
  FoodCategory foodCategory;

  RecipeModel({
    required this.foodCategory,
    required this.name,
    required this.ingredients,
    required this.steps,
  });
}
