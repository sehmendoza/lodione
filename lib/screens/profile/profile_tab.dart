import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  TextEditingController usernameController =
      TextEditingController(text: 'sehmendoza');
  TextEditingController fullNameController =
      TextEditingController(text: 'Jose Gabriel Mendoza');
  bool editUsername = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.white,
              width: 2,
            )),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                profileTextfield(
                    controller: usernameController,
                    edit: editUsername,
                    label: 'Username'),
                IconButton(
                    onPressed: () {
                      setState(() {
                        editUsername = !editUsername;
                      });
                    },
                    icon: editUsername
                        ? const Icon(
                            Icons.check,
                            color: Colors.white60,
                          )
                        : const Icon(
                            Icons.edit,
                            color: Colors.white60,
                          ))
              ],
            ),
            Row(
              children: [
                profileTextfield(
                    controller: fullNameController,
                    edit: false,
                    label: 'Full name'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget profileTextfield({
  required controller,
  required edit,
  required label,
}) {
  return Expanded(
    child: TextField(
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
    ),
  );
}
