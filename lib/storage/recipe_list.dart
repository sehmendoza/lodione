import '../models/recipe_model.dart';
import '../providers/list_provider.dart';

List<RecipeModel> recipes = [
  RecipeModel(
    foodCategory: FoodCategory.breakfast,
    isFavorite: false,
    name: 'Goto',
    ingredients: [
      ItemModel(name: 'name', isDone: false, details: ''),
      ItemModel(name: 'fff', isDone: false, details: ''),
      ItemModel(name: 'gfg', isDone: false, details: ''),
    ],
    steps: ['rfasefas', 'asefasef', 'aseflkjasefl'],
  ),
  RecipeModel(
    foodCategory: FoodCategory.lunch,
    name: 'Dinuguan',
    isFavorite: false,
    ingredients: [
      ItemModel(name: 'ghashh', isDone: false, details: ''),
      ItemModel(name: 'vcvav', isDone: false, details: ''),
      ItemModel(name: 'asdfsadf', isDone: false, details: ''),
    ],
    steps: ['324ef3', 'vase32f32', 'vasef32fawf'],
  )
];
