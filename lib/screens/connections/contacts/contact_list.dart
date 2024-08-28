import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lodione/screens/connections/contacts/contacts_tab.dart';
import 'package:lodione/widgets/buttons.dart';

class ConnectionList extends StatelessWidget {
  const ConnectionList({required this.group, super.key});
  final GroupConnection group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white60,
                    ),
                    hintStyle: const TextStyle(color: Colors.white54),
                    hintText: 'Search name',
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: MyButton(
                  text: 'Add user',
                  icon: Icons.add,
                  onPressed: () => addUserDialog(context),
                ),
              )
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
                      user.username,
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

  void addUserDialog(context) {
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
                'Add user',
                style: TextStyle(color: Colors.white),
              ),
            ),
            content: const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
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
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
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
}
