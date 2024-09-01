import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'create_account.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Using ValueNotifier for better state management

  String _username = '';
  final String _password = '';
  bool _visiblePW = false;
  bool userFound = false;

  void _handleEnterKey() {
    print('Enter key pressed!');
    // Add your logic here for what should happen when Enter is pressed
  }

  void signIn(context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save the form data

      try {
        FirebaseFirestore.instance.collection('users').get().then((value) {
          for (var i in value.docs) {
            if (i['username'] == _username) {
              userFound = true;
            }
          }
        });
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _username,
          password: _password,
        );
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
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            _username = '';
                          },
                          icon: const Icon(Icons.close),
                        ),
                        label: Text('Username',
                            style:
                                TextStyle(color: Colors.white.withAlpha(200))),
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
                      style: const TextStyle(
                          color: Colors.white, letterSpacing: 2),
                      onFieldSubmitted: (value) {
                        _username = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autocorrect: false,
                      obscureText: !_visiblePW,
                      decoration: InputDecoration(
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
                        label: Text('Password',
                            style:
                                TextStyle(color: Colors.white.withAlpha(200))),
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
                      style: const TextStyle(
                          color: Colors.white, letterSpacing: 2),
                      onFieldSubmitted: (value) {
                        signIn(context);
                      },
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
