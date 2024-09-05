import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lodione/const.dart';
import 'package:lodione/screens/auth/sign_in_screen.dart';
import 'package:lodione/screens/main/main_screen.dart';
import 'package:provider/provider.dart';
import 'providers/list_provider.dart';
import 'providers/userist_provider.dart';
import 'services/firebase_options.dart';
import 'screens/main/waiting_screen.dart';
import 'test/task_screen.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    runApp(
      MultiProvider(
        providers: [
          //  ChangeNotifierProvider(create: (context) => ListProvider()),
          ChangeNotifierProvider(create: (context) => UseristProvider()),
        ],
        child: const LodioneApp(),
      ),
    );
  } catch (e) {
    runApp(const ErrorScreen());
  }
}

class LodioneApp extends StatelessWidget {
  const LodioneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      home: const StartUp(),
    );
  }
}

class StartUp extends StatelessWidget {
  const StartUp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth
          .instance.currentUser, // If you want to avoid waiting state initially
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const WaitingScreen();
        } else if (snapshot.hasError) {
          return const ErrorScreen();
        } else if (snapshot.hasData) {
          return const MainScreen();
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('An error occurred'),
            SizedBox(height: 20),
            Text('Please reload the app'),
          ],
        ),
      ),
    );
  }
}
