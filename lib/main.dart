import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lodione/widgets/const.dart';
import 'package:lodione/screens/auth/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'services/firebase_options.dart';
import 'screens/main_screen.dart';
import 'screens/main/waiting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const StartUp(),
    // MultiProvider(
    //   providers: const [
    //     // ChangeNotifierProvider(create: (context) => UserProvider()),

    //     // Add other providers here
    //   ],
    //   child:
    // ),
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
