import 'list_model.dart';
import 'package:flutter/material.dart';

enum FoodCategory { meals, treats, others }

const categoryIcon = {
  FoodCategory.meals: Icons.dinner_dining,
  FoodCategory.treats: Icons.cookie,
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
