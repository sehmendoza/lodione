import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lodione/const.dart';
import 'package:lodione/providers/list_provider.dart';
import 'package:provider/provider.dart';

import '../../models/list_model.dart';
import '../../models/user_model.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String username = '', email = '', password = '', cpassword = '', name = '';

  void _createAccount(context) async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    if (isValid) {
      try {
        // Use createUserWithEmailAndPassword for account creation
        final userCred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        final newUser = UserModel(
            id: userCred.user!.uid,
            username: username,
            email: email,
            name: name,
            createdAt: Timestamp.now().toString(),
            isPrivate: true);
        // ref.watch(allUserProvider).addUser(newUser);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(newUser.id)
            .set(
              newUser.toFirestore(),
            );

        // final newList = ListModel(
        //   createdBy: userCred.user!.uid,
        //   dateCreated: Timestamp.now().toString(),
        //   shareWith: [],
        //   name: 'My List',
        //   items: [],
        // );

        // Provider.of<ListProvider>(context, listen: false).addList(newList);

        Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred. Please try again.';
        switch (e.code) {
          case 'weak-password':
            errorMessage = 'The password provided is too weak.';
          case 'email-already-in-use':
            errorMessage = 'The account already exists for that email.';
          case 'invalid-email':
            errorMessage = 'The email address is badly formatted.';
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Center(child: Text(errorMessage))),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Center(
                  child: SelectableText(
                      'An unexpected error occurred: ${e.toString()}'))),
        );
      }
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
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: 420,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => name = value,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(
                          color: Colors.white, letterSpacing: 2),
                      decoration: myTextfieldDeco('Name (optional)'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an email address';
                        } else if (!value.contains('@') ||
                            !value.contains('.')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onChanged: (value) => email = value,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      style: const TextStyle(
                          color: Colors.white, letterSpacing: 2),
                      decoration: myTextfieldDeco('Email address'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a username';
                        } else if (value.length < 3) {
                          return 'Username must be at least 3 characters';
                        } else if (value.contains(' ')) {
                          return 'Username cannot contain spaces';
                        } else if (value.contains(
                            RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]'))) {
                          return 'Username cannot contain special characters';
                        }
                        return null;
                      },
                      onChanged: (value) => username = value,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      style: const TextStyle(
                          color: Colors.white, letterSpacing: 2),
                      decoration: myTextfieldDeco('Username'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      obscureText: true,
                      onChanged: (value) => password = value,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      style: const TextStyle(
                          color: Colors.white, letterSpacing: 2),
                      decoration: myTextfieldDeco('New password'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != password) {
                          return 'Passwords do not match';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      obscureText: true,
                      onChanged: (value) => cpassword = value,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      style: const TextStyle(
                          color: Colors.white, letterSpacing: 2),
                      decoration: myTextfieldDeco('Confirm password'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    myButton1('Submit', () {
                      _createAccount(context);
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
