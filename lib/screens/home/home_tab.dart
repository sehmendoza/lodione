import 'package:flutter/material.dart';

import 'lists/list_tab.dart';
import 'meal_plan/mp_tab.dart';
import 'places/places_tab.dart';
import 'recipes/recipe_tab.dart';
import 'workout/workout_tab.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<TabItems> menus = [
    TabItems(
      title: 'Lists',
      icon: Icons.list,
      goTo: const ListTab(),
    ),
    TabItems(
      title: 'Recipes',
      icon: Icons.menu_book,
      goTo: const RecipeTab(),
    ),
    TabItems(
      title: 'Meal Plan',
      icon: Icons.restaurant,
      goTo: const MealPlanTab(),
    ),
    TabItems(
      title: 'Go-to Places',
      icon: Icons.place,
      goTo: const GotoPlaces(),
    ),
    TabItems(
      title: 'Fitness',
      icon: Icons.fitness_center,
      goTo: const WorkoutTab(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: menus.length,
      child: Scaffold(
        appBar: TabBar(
          labelColor: Colors.white,
          labelStyle: const TextStyle(
              color: Colors.white,
              letterSpacing: 2,
              fontWeight: FontWeight.w500),
          unselectedLabelColor: Colors.white54,
          unselectedLabelStyle: const TextStyle(color: Colors.white54),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          indicatorColor: Colors.white,
          tabs: menus.map((TabItems menu) {
            return Tab(
              text: size > 690 ? menu.title : null,
              icon: Icon(
                menu.icon,
              ),
            );
          }).toList(),
        ),
        backgroundColor: Colors.black,
        body: TabBarView(
          children: menus.map((TabItems menu) {
            return menu.goTo;
          }).toList(),
        ),
      ),
    );
  }
}

class TabItems {
  String title;
  IconData icon;
  Widget goTo;

  TabItems({required this.title, required this.icon, required this.goTo});
}
