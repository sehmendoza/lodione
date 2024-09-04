import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lodione/screens/auth/sign_in_screen.dart';
import 'package:lodione/screens/profile/profile_tab.dart';
import 'package:lodione/screens/connections/connection_tab.dart';
import 'package:provider/provider.dart';

import '../providers/list_provider.dart';
import '../providers/user_provider.dart';
import 'home/home_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  void onTappedBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void logout(context) async {
    try {
      // Sign out from Firebase Authentication
      await FirebaseAuth.instance.signOut();
      Provider.of<UserProvider>(context, listen: false).clearUserData();

      // Navigate to login screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
      // Show a snackbar or any UI feedback to confirm logout
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out successfully')),
      );
    } catch (e) {
      print('Error signing out: $e');
      // Handle error, maybe show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to log out. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      const HomeTab(),
      ConnectionTab(),
      const ProfileTab(),
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      // drawer: MyDrawer(
      //   onTap: () {
      //     onTappedBar(2);
      //     Navigator.of(context).pop();
      //   },
      // ),
      appBar: AppBar(
        leadingWidth: 200,

        leading: Image.asset(
          'lib/images/lodione_logo_side.png',
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
        // centerTitle: true,
        // title: Image.asset(
        //   'lib/images/lodione_logo_lang.png',
        //   height: 40,
        // ),
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
            label: 'Home',
            icon: Icon(Icons.home_rounded),
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
      body: children[currentIndex],
    );
  }
}
