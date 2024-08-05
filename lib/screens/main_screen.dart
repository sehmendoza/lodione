import 'package:flutter/material.dart';
import 'package:lodione/screens/home_screen.dart';

import 'create_account.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool visiblePW = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  Image.asset(
                    'lib/images/lodione_logo.png',
                    height: 250,
                  ),
                  TextField(
                    controller: usernameController,
                    style:
                        const TextStyle(color: Colors.white, letterSpacing: 2),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              usernameController.clear();
                            });
                          },
                          icon: const Icon(Icons.close)),
                      label: Text(
                        'Username',
                        style: TextStyle(color: Colors.white.withAlpha(200)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: visiblePW,
                    style:
                        const TextStyle(color: Colors.white, letterSpacing: 2),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          visiblePW ? Icons.visibility_off : Icons.visibility,
                          // color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            visiblePW = !visiblePW;
                          });
                        },
                      ),
                      label: Text(
                        'Password',
                        style: TextStyle(color: Colors.white.withAlpha(200)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(160, 30),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(160, 30),
                      backgroundColor: Colors.black,
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateAccount(),
                        ),
                      );
                    },
                    child: const Text(
                      'Create account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
