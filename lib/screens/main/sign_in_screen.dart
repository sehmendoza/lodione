import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'create_account.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool visiblePW = true;

  void signIn(context) async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const MainScreen(),
        //   ),
        // );
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred. Please try again.';
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found for that email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided for that user.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is badly formatted.';
            break;
          case 'user-disabled':
            errorMessage =
                'The user account has been disabled. Please contact support.';
            break;
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Center(child: Text(errorMessage))),
        );
      }
    } else {
      return;
    }
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
                    TextFormField(
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value!.isEmpty || value.trim().isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                      controller: usernameController,
                      style: const TextStyle(
                          color: Colors.white, letterSpacing: 2),
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
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 109, 17, 11),
                              width: 1),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 109, 17, 11),
                              width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autocorrect: false,
                      validator: (value) {
                        if (value!.isEmpty || value.trim().isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: visiblePW,
                      style: const TextStyle(
                          color: Colors.white, letterSpacing: 2),
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
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 109, 17, 11),
                              width: 1),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 109, 17, 11),
                              width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        fixedSize: const Size(200, 40),
                      ),
                      onPressed: () => signIn(context),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.white,
                        elevation: 5,
                        fixedSize: const Size(200, 40),
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
                        style: TextStyle(color: Colors.white, letterSpacing: 2),
                      ),
                    ),
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
