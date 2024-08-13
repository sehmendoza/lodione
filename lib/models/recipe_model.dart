import 'list_model.dart';
import 'package:flutter/material.dart';

enum FoodCategory { breakfast, lunch, dinner, snacks, desserts, others }

const categoryIcon = {
  FoodCategory.breakfast: Icons.coffee,
  FoodCategory.lunch: Icons.lunch_dining,
  FoodCategory.dinner: Icons.dinner_dining,
  FoodCategory.snacks: Icons.cookie,
  FoodCategory.desserts: Icons.icecream,
  FoodCategory.others: Icons.fastfood
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
