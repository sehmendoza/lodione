import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lodione/providers/user_provider.dart';
import 'package:lodione/widgets/buttons.dart';
import 'package:lodione/widgets/dialogs.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    void editProfile() {
      var usernameController =
          TextEditingController(text: userData['username']);
      var nameController =
          TextEditingController(text: userData['name'] ?? 'No Name');
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
                    onPressed: () {
                      if (usernameController.text.isEmpty) {
                        return showMyErrorDialog(
                            context, 'Error', 'Username cannot be empty');
                      } else if (userData['username'] ==
                              usernameController.text &&
                          userData['name'] == nameController.text) {
                        return Navigator.of(context).pop();
                      }
                      ref.read(userDataProvider.notifier).updateUserData({
                        'name': nameController.text,
                        'username': usernameController.text,
                      });
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: userData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Center(
                        child: Text('My Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      profileTextfield(
                        controller: TextEditingController(
                            text: userData['name'] ?? 'No Name'),
                        edit: false,
                        label: 'Preferred name',
                      ),
                      profileTextfield(
                        controller:
                            TextEditingController(text: userData['username']),
                        edit: false,
                        label: 'Username',
                      ),

                      // Private Account Switch
                      SwitchListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        thumbIcon: WidgetStateProperty.all(
                          Icon(userData['isPrivate']
                              ? Icons.lock
                              : Icons.lock_open),
                        ),
                        title: const Text('Private account',
                            style: TextStyle(color: Colors.white)),
                        subtitle: const Text('Your profile will be private',
                            style: TextStyle(color: Colors.white60)),
                        value: userData['isPrivate'] ?? true,
                        onChanged: (value) {
                          ref
                              .read(userDataProvider.notifier)
                              .updateUserData({'isPrivate': value});
                        },
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                MyButton(
                    text: ' Edit Profile',
                    icon: Icons.edit,
                    onPressed: editProfile)
              ],
            ),
    );
  }
}

final editUsernameProvider = StateProvider<bool>((ref) => false);

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
