import 'package:flutter/material.dart';
import 'package:lodione/screens/home/meal_plan/mp_detail.dart';

class MealPlanTab extends StatelessWidget {
  const MealPlanTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 8,
            top: 10,
          ),
          child: Text(
            "Today's Date: 05/23/24 - Monday - 05:24 PM",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: const [
                DayMealSection(day: 'Sunday'),
                DayMealSection(day: 'Monday'),
                DayMealSection(day: 'Tuesday'),
                DayMealSection(day: 'Wednesday'),
                DayMealSection(day: 'Thursday'),
                DayMealSection(day: 'Friday'),
                DayMealSection(day: 'Saturday'),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class DayMealSection extends StatelessWidget {
  final String day;
  const DayMealSection({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(
          color: Colors.white,
          width: 2,
        ),
      ),
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        title: Text(
          day,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          MealItem(
            day: day,
            iconData: Icons.free_breakfast_outlined,
            mealType: 'Breakfast',
          ),
          MealItem(
            day: day,
            iconData: Icons.lunch_dining,
            mealType: 'Lunch',
          ),
          MealItem(
            day: day,
            iconData: Icons.cookie,
            mealType: 'Snack',
          ),
          MealItem(
            day: day,
            iconData: Icons.dinner_dining,
            mealType: 'Dinner',
          ),
        ],
      ),
    );
  }
}

class MealItem extends StatelessWidget {
  final String day;
  final String mealType;
  //final String mealName;
  final IconData iconData;

  const MealItem(
      {super.key,
      required this.day,
      required this.mealType,
      // required this.mealName,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Colors.white,
        size: 28,
      ),
      title: Text(
        mealType,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white60,
        ),
      ),
      // subtitle: Text(
      //   mealName,
      //   style: const TextStyle(
      //     fontSize: 16,
      //     color: Colors.white,
      //   ),
      // ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealPlanDetail(day: day, mealType: mealType),
          ),
        );
      },
    );
  }
}
