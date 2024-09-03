import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lodione/models/user_model.dart';
import '../../widgets/buttons.dart';
import 'profile_view.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!;
              UserModel user = UserModel.fromFirestore(userData);

              return Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          )),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(8),
                      child: ProfileView(user: user)),
                  // MyButton(
                  //     text: 'Edit Profile',
                  //     icon: Icons.edit,
                  //     onPressed: () {
                  //       // editProfile();
                  //     }),
                ],
              );
            }
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const WaitingScreen();
            // }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else {
              return const Text('Loading...');
            }
          }),
    );
  }
}

Widget profileTextfield({
  required controller,
  required edit,
  required label,
}) {
  return TextField(
    style: const TextStyle(color: Colors.white),
    controller: controller,
    enabled: edit,
    decoration: InputDecoration(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white60),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white70,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white70,
          width: 2,
        ),
      ),
    ),
  );
}
