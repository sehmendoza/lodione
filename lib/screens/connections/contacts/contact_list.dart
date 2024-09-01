import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lodione/providers/user_provider.dart';
import 'package:lodione/screens/connections/contacts/contacts_tab.dart';
import 'package:lodione/widgets/buttons.dart';

import '../../../models/notification_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ConnectionList extends ConsumerWidget {
  const ConnectionList({required this.group, super.key});
  final GroupConnection group;

  void addUser(String username, WidgetRef ref) async {
    final users = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    final fromUsername = ref.read(userProvider)!.username;

    var notify = NotificationModel(
      type: NotificationType.friendRequest,
      message: 'Friend request from $fromUsername',
    );

    _firestore.collection('users').doc(users.docs[0].data()['id']).set({
      'notification': FieldValue.arrayUnion([notify.toFirestore()])
    });
  }

  void addUserDialog(context, ref) {
    var username = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Center(
              child: Text(
                'Add by Username',
                style: TextStyle(color: Colors.white),
              ),
            ),
            content: TextField(
              controller: username,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter username',
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel',
                    style: TextStyle(color: Colors.white60)),
              ),
              TextButton(
                onPressed: () {
                  addUser(username.text, ref);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Send request',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white60,
                    ),
                    hintStyle: const TextStyle(color: Colors.white54),
                    hintText: 'Search name',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {},
                      color: Colors.white60,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              MyButton(
                  text: 'Add a friend',
                  icon: Icons.add,
                  onPressed: () => addUserDialog(context, ref))
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: group.users.length,
              itemBuilder: (context, index) {
                var user = group.users[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                    title: Text(
                      user.name,
                      style: const TextStyle(
                          fontSize: 21,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2),
                    ),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                width: 2,
                                color: Colors.white,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                width: 2,
                                color: Colors.white,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                width: 2,
                                color: Colors.white,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Share',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {},
                              leading: const Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 32,
                              ),
                              title: const Text(
                                'Call ',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: const Icon(
                                Icons.email,
                                color: Colors.white,
                                size: 32,
                              ),
                              title: const Text(
                                'Send a message',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: const Icon(
                                Icons.handshake_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                              title: const Text(
                                'Set-up connection',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
