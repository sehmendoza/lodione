import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lodione/const.dart';
import 'package:lodione/screens/main/sign_in_screen.dart';

import 'firebase_options.dart';
import 'screens/main/main_screen.dart';
import 'screens/main/waiting_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // ).then((fn) => const StartUp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const ProviderScope(
      child: StartUp(),
    ),
  );
}

class StartUp extends StatelessWidget {
  const StartUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const WaitingScreen();
              }
              if (snapshot.hasData) {
                return const MainScreen();
              }
              return const SignInScreen();
            }));
  }
}
