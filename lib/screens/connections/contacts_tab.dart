import 'package:flutter/material.dart';

class ContactsTab extends StatefulWidget {
  const ContactsTab({super.key});

  @override
  State<ContactsTab> createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> {
  List<GroupConnection> groups = [
    GroupConnection(
      title: 'All',
      users: [
        UserModel(username: 'sehmendoza'),
        UserModel(username: 'recypoli'),
      ],
    ),
    GroupConnection(
      title: 'Family',
      users: [
        UserModel(username: 'sehmendoza'),
        UserModel(username: 'gian'),
        UserModel(username: 'gsel'),
        UserModel(username: 'mami'),
        UserModel(username: 'dadi'),
      ],
    ),
    GroupConnection(
      title: 'Friends',
      users: [
        UserModel(username: 'sehmendoza'),
        UserModel(username: 'sam'),
        UserModel(username: 'brian'),
        UserModel(username: 'philip'),
        UserModel(username: 'ads'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: groups.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Row(
            children: [
              Expanded(
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.white,
                  labelStyle: const TextStyle(
                      color: Colors.white,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500),
                  unselectedLabelColor: Colors.white54,
                  unselectedLabelStyle: const TextStyle(color: Colors.white54),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3,
                  indicatorColor: Colors.white,
                  tabs: groups.map((GroupConnection group) {
                    return Tab(
                      child: Text(group.title),
                    );
                  }).toList(),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      groups.add(
                        GroupConnection(
                          title: 'Friends',
                          users: [
                            UserModel(username: 'sehmendoza'),
                            UserModel(username: 'sam'),
                            UserModel(username: 'brian'),
                            UserModel(username: 'philip'),
                            UserModel(username: 'ads'),
                          ],
                        ),
                      );
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: TabBarView(
          children: groups.map((GroupConnection group) {
            return ConnectionList(
              group: group,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ConnectionList extends StatelessWidget {
  const ConnectionList({required this.group, super.key});
  final GroupConnection group;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
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
                borderSide: const BorderSide(color: Colors.white, width: 2),
              ),
            ),
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
}

class GroupConnection {
  String title;
  List<UserModel> users;

  GroupConnection({required this.title, required this.users});
}

class UserModel {
  String username;

  UserModel({required this.username});
}
