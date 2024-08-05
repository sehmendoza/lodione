import 'list_model.dart';

class RecipeModel {
  String name;
  List<ListItem> ingredients;
  List<String> steps;

  RecipeModel({
    required this.name,
    required this.ingredients,
    required this.steps,
  });
}
