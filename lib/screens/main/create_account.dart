import 'package:flutter/material.dart';
import 'package:lodione/screens/connections/contacts/contacts_tab.dart';
import 'package:lodione/storage/user_list.dart';

import 'main_screen.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    super.dispose();
  }

  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      userList.add(
        UserModel(username: usernameController.text),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text(
          'Create Account',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              textfield1(usernameController, 'Username', (value) {
                if (value.isEmpty) {
                  return 'Please enter a username';
                } else if (value.length < 3) {
                  return 'Username must be at least 3 characters';
                }
                return null;
              }),
              const SizedBox(
                height: 20,
              ),
              textfield1(emailController, 'Email address', (value) {
                if (value.isEmpty) {
                  return 'Please enter an email address';
                } else if (!value.contains('@') || !value.contains('.')) {
                  return 'Please enter a valid email address';
                }
                return null;
              }),
              const SizedBox(
                height: 20,
              ),
              textfieldpw1(passwordController, 'New password', (value) {
                if (value.isEmpty) {
                  return 'Please enter a password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              }),
              const SizedBox(
                height: 20,
              ),
              textfieldpw1(cpasswordController, 'Confirm password', (value) {
                if (value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != passwordController.text) {
                  return 'Passwords do not match';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              }),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _createAccount,
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.white,
                    elevation: 5,
                    fixedSize: const Size(250, 40),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    side: const BorderSide(width: 2, color: Colors.white)),
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      )),
    );
  }
}

Widget textfield1(controller, label, validate) {
  return TextFormField(
    validator: validate,
    controller: controller,
    style: const TextStyle(color: Colors.white, letterSpacing: 2),
    decoration: InputDecoration(
      label: Text(
        label,
        style: TextStyle(color: Colors.white.withAlpha(200)),
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
  );
}

Widget textfieldpw1(controller, label, validate) {
  return TextFormField(
    validator: validate,
    controller: controller,
    obscureText: true,
    style: const TextStyle(color: Colors.white, letterSpacing: 2),
    decoration: InputDecoration(
      label: Text(
        label,
        style: TextStyle(color: Colors.white.withAlpha(200)),
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
  );
}

// class User {
//   String? username;
//   String? emailAddress;
//   String? password;
//   String? id;


// }
