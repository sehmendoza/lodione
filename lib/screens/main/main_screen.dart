import 'package:flutter/material.dart';
import 'package:lodione/screens/profile/profile_tab.dart';
import 'package:lodione/screens/connections/connection_tab.dart';
import 'package:lodione/screens/home/home_tab.dart';
import 'package:lodione/services/auth_service.dart';

import '../auth/sign_in_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomeTab(),
    ConnectionTab(),
    const ProfileTab(),
  ];

  final AuthService _authService = AuthService();

  void _onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _logout(BuildContext context) async {
    try {
      await _authService.logout();
      // Navigate to login screen or show success message
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SignInScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: 200,
        leading: Image.asset('lib/images/lodione_logo_side.png'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onTappedBar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
            tooltip: 'Navigate to Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Connections',
            tooltip: 'View Connections',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            tooltip: 'View Profile',
          ),
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
