import 'package:flutter/material.dart';
import 'package:lodione/screens/profile_tab.dart';
import 'package:lodione/screens/social_tab.dart';

import 'wellness/wellness_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _children = [
    const WellnessTab(),
    const SocialTab(),
    const ProfileTab(),
  ];
  int currentIndex = 0;

  void onTappedBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'lib/images/lodione_logo_lang.png',
          height: 40,
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        backgroundColor: Colors.black,
        currentIndex: currentIndex,
        onTap: onTappedBar,
        items: const [
          BottomNavigationBarItem(
            label: 'Wellness',
            icon: Icon(Icons.health_and_safety),
          ),
          BottomNavigationBarItem(
            label: 'Connections',
            icon: Icon(Icons.people),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: _children[currentIndex],
    );
  }
}
