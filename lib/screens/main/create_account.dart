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
    if (usernameController.text.trim().isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        cpasswordController.text.isEmpty) {
      return;
    }
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
        child: Column(
          children: [
            textfield1(usernameController, 'Username'),
            const SizedBox(
              height: 20,
            ),
            textfield1(emailController, 'Email address'),
            const SizedBox(
              height: 20,
            ),
            textfieldpw1(passwordController, 'New password'),
            const SizedBox(
              height: 20,
            ),
            textfieldpw1(cpasswordController, 'Confirm password'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _createAccount,
              style: ElevatedButton.styleFrom(fixedSize: const Size(250, 40)),
              child: const Text('Submit'),
            )
          ],
        ),
      )),
    );
  }
}

Widget textfield1(controller, label) {
  return TextField(
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
    ),
  );
}

Widget textfieldpw1(controller, label) {
  return TextField(
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
    ),
  );
}

// class User {
//   String? username;
//   String? emailAddress;
//   String? password;
//   String? id;


// }
