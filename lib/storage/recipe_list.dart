import '../models/list_model.dart';
import '../models/recipe_model.dart';

List<RecipeModel> recipes = [
  RecipeModel(
    foodCategory: FoodCategory.breakfast,
    isFavorite: false,
    name: 'Goto',
    ingredients: [
      ItemModel(
        name: 'name',
        isDone: false,
      ),
      ItemModel(
        name: 'fff',
        isDone: false,
      ),
      ItemModel(
        name: 'gfg',
        isDone: false,
      ),
    ],
    steps: ['rfasefas', 'asefasef', 'aseflkjasefl'],
  ),
  RecipeModel(
    foodCategory: FoodCategory.lunch,
    name: 'Dinuguan',
    isFavorite: false,
    ingredients: [
      ItemModel(
        name: 'ghashh',
        isDone: false,
      ),
      ItemModel(
        name: 'vcvav',
        isDone: false,
      ),
      ItemModel(
        name: 'asdfsadf',
        isDone: false,
      ),
    ],
    steps: ['324ef3', 'vase32f32', 'vasef32fawf'],
  )
];
