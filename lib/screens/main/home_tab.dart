import 'package:flutter/material.dart';

import '../home/lists/list_tab.dart';
import '../home/meal_plan/mp_tab.dart';
import '../home/places/places_tab.dart';
import '../home/recipes/recipe_tab.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<MenuItems> menus = [
    MenuItems(
      title: 'Lists',
      icon: Icons.list,
      goTo: const ListTab(),
    ),
    MenuItems(
      title: 'Recipes',
      icon: Icons.menu_book,
      goTo: const RecipeTab(),
    ),
    MenuItems(
      title: 'Meal Plan',
      icon: Icons.restaurant,
      goTo: const MealPlanTab(),
    ),
    MenuItems(
      title: 'Go-to Places',
      icon: Icons.place,
      goTo: const GotoPlaces(),
    ),
    MenuItems(
      title: 'Fitness',
      icon: Icons.fitness_center,
      goTo: const ListTab(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
          tabs: menus.map((MenuItems menu) {
            return Tab(
              icon: Icon(
                menu.icon,
                color: Colors.white,
              ),
            );
          }).toList(),
        ),
        backgroundColor: Colors.black,
        body: TabBarView(
          children: menus.map((MenuItems menu) {
            return menu.goTo;
          }).toList(),
        ),
      ),
    );
  }
}

class MenuItems {
  String title;
  IconData icon;
  Widget goTo;

  MenuItems({required this.title, required this.icon, required this.goTo});
}
