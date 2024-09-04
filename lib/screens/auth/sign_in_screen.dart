import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lodione/const.dart';
import 'package:lodione/screens/main/main_screen.dart';
import '../../providers/auth_provider.dart';

import '../../widgets/dialogs.dart';
import 'create_account.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _visiblePW = false;
  // final bool _isLoading = false;

  final AuthService _authService = AuthService();

  void signIn(context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    User? user = await _authService.signInWithUsername(username, password);
    // Successfully signed in

    if (user == null) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return myAlertDialog(
            context,
            'Invalid username or password',
          );
        },
      );
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
    // Navigate to the next screen
  }

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
              child: Form(
                key: _formKey,
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
                    myTextfield(
                      controller: _usernameController,
                      label: 'Username',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _usernameController.clear();
                          });
                        },
                        icon: const Icon(Icons.close),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    myTextfield(
                      label: 'Password',
                      controller: _passwordController,
                      visible: !_visiblePW,
                      suffixIcon: IconButton(
                        icon: Icon(_visiblePW
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _visiblePW = !_visiblePW;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    myButton1(
                      'Sign In',
                      () => signIn(context),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    myButton2('Create account', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateAccount(),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget myTextfield({
  required TextEditingController controller,
  bool? visible,
  Widget? suffixIcon,
  String? label,
  String? Function(String?)? validator,
  Function(String)? onChanged,
  TextCapitalization? textCapital,
}) {
  return TextFormField(
    controller: controller,
    obscureText: visible ?? false,
    autocorrect: false,
    textCapitalization: textCapital ?? TextCapitalization.none,
    onChanged: onChanged,
    validator: validator,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      label: Text(
        label ?? '',
        style: TextStyle(
          color: Colors.white.withAlpha(200),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromARGB(255, 109, 17, 11), width: 1),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromARGB(255, 109, 17, 11), width: 2),
      ),
    ),
    style: const TextStyle(color: Colors.white, letterSpacing: 2),
  );
}
