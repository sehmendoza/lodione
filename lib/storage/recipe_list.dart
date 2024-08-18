import '../models/list_model.dart';
import '../models/recipe_model.dart';

List<RecipeModel> recipes = [
  RecipeModel(
    foodCategory: FoodCategory.breakfast,
    isFavorite: false,
    name: 'Goto',
    ingredients: [
      ListItem(
        name: 'name',
        isDone: false,
      ),
      ListItem(
        name: 'fff',
        isDone: false,
      ),
      ListItem(
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
      ListItem(
        name: 'ghashh',
        isDone: false,
      ),
      ListItem(
        name: 'vcvav',
        isDone: false,
      ),
      ListItem(
        name: 'asdfsadf',
        isDone: false,
      ),
    ],
    steps: ['324ef3', 'vase32f32', 'vasef32fawf'],
  )
];
