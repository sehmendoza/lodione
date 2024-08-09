import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  TextEditingController usernameController =
      TextEditingController(text: 'sehmendoza');
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
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: usernameController,
                    enabled: editUsername,
                    decoration: const InputDecoration(
                      label: Text(
                        'Username',
                        style: TextStyle(color: Colors.white60),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white70,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white70,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
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
            )
          ],
        ),
      ),
    );
  }
}
