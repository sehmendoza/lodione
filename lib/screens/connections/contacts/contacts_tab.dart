import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import 'contact_list.dart';

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
        // UserModel(username: 'sehmendoza'),
        // UserModel(username: 'recypoli'),
      ],
    ),
    GroupConnection(
      title: 'Family',
      users: [
        // UserModel(username: 'sehmendoza'),
        // UserModel(username: 'gian'),
        // UserModel(username: 'gsel'),
        // UserModel(username: 'mami'),
        // UserModel(username: 'dadi'),
      ],
    ),
    GroupConnection(
      title: 'Friends',
      users: [
        // UserModel(username: 'sehmendoza'),
        // UserModel(username: 'sam'),
        // UserModel(username: 'brian'),
        // UserModel(username: 'philip'),
        // UserModel(username: 'ads'),
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
                            // UserModel(username: 'sehmendoza'),
                            // UserModel(username: 'sam'),
                            // UserModel(username: 'brian'),
                            // UserModel(username: 'philip'),
                            // UserModel(username: 'ads'),
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

class GroupConnection {
  String title;
  List<UserModel> users;

  GroupConnection({required this.title, required this.users});
}

// class UserModel {
//   String username;
//   UserModel({required this.username});

//   Map<String, dynamic> toMap() {
//     return {
//       'username': username,
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> data) {
//     return UserModel(
//       username: data['username'],
//     );
//   }
// }
