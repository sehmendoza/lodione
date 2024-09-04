import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lodione/const.dart';
import 'package:lodione/models/user_model.dart';
import 'package:lodione/screens/auth/sign_in_screen.dart';
import 'package:lodione/test/task_screen.dart';
import 'package:provider/provider.dart';
import 'providers/list_provider.dart';
import 'providers/user_provider.dart';
import 'services/firebase_options.dart';
import 'screens/main_screen.dart';
import 'screens/main/waiting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        //  Add other providers here
      ],
      child: MaterialApp(
        theme: myTheme,
        // darkTheme: darkTheme,
        // themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const StartUp(),
      ),
    ),
  );
}

class StartUp extends StatelessWidget {
  const StartUp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const WaitingScreen();
          }
          if (snapshot.hasData) {
            return const ToDoListScreen();
          }
          return const SignInScreen();
        });
  }
}
