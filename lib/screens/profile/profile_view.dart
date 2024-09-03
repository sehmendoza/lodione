import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lodione/screens/profile/profile_tab.dart';
import 'package:lodione/widgets/dialogs.dart';
import '../../models/user_model.dart';
import '../../widgets/buttons.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.user});

  final UserModel user;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  _updatePrivacy(bool value) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.id)
        .update({'isPrivate': value});
  }

  void editProfile() {
    var usernameController = TextEditingController(text: widget.user.username);
    var nameController = TextEditingController(text: widget.user.name);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Center(
              child:
                  Text('Edit Profile', style: TextStyle(color: Colors.white)),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                profileTextfield(
                  controller: nameController,
                  edit: true,
                  label: 'Preferred name',
                ),
                const SizedBox(height: 10),
                profileTextfield(
                  controller: usernameController,
                  edit: true,
                  label: 'Username',
                ),
                const SizedBox(height: 14),
                const Text('Email address cannot be changed',
                    style: TextStyle(color: Colors.white60)),
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              MyButton(
                  text: 'Save',
                  icon: Icons.save,
                  onPressed: () async {
                    if (usernameController.text.isEmpty) {
                      return showMyErrorDialog(
                          context, 'Error', 'Username cannot be empty');
                    } else if (widget.user.username ==
                            usernameController.text &&
                        widget.user.name == nameController.text) {
                      return Navigator.of(context).pop();
                    }
                    widget.user.name = nameController.text;
                    widget.user.username = usernameController.text;

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.user.id)
                        .update({
                      'name': widget.user.name,
                      'username': widget.user.username,
                    });

                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.user;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Account Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            MyButton(text: ' Edit', icon: Icons.edit, onPressed: editProfile)
          ],
        ),

        myProfileBox('Name', user.name == '' ? 'Unknown' : user.name),
        myProfileBox('Username', '@${user.username}'),
        myProfileBox('Email address', user.email),

        // Private Account Switch
        SwitchListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          thumbIcon: WidgetStateProperty.all(
            Icon(user.isPrivate ? Icons.lock : Icons.lock_open),
          ),
          title: const Text('Private account',
              style: TextStyle(color: Colors.white)),
          subtitle: const Text('Your profile will be private',
              style: TextStyle(color: Colors.white60)),
          value: user.isPrivate,
          onChanged: (value) async {
            user.isPrivate = value;
            await _updatePrivacy(value);
          },
          activeColor: Colors.white,
        ),
      ],
    );
  }
}

Widget myProfileBox(title, value) {
  return ListTile(
    title: Text(title, style: const TextStyle(color: Colors.white60)),
    subtitle: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(value,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, letterSpacing: 2)),
    ),
  );
}
