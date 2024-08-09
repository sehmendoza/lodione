import 'package:flutter/material.dart';

import 'contacts_tab.dart';
import 'events_tab.dart';

class ConnectionTab extends StatelessWidget {
  ConnectionTab({super.key});

  final List<ConnectTab> tabs = [
    ConnectTab(
      name: 'Contacts',
      iconData: Icons.contact_emergency,
      child: const ContactsTab(),
    ),
    ConnectTab(
      name: 'Events',
      iconData: Icons.groups,
      child: const EventsTab(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: TabBar(
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
          tabs: tabs.map((ConnectTab tab) {
            return Tab(
              icon: Icon(tab.iconData),
              // child: Text(tab.name),
            );
          }).toList(),
        ),
        backgroundColor: Colors.black,
        body: TabBarView(
          children: tabs.map((ConnectTab tab) {
            return tab.child;
          }).toList(),
        ),
      ),
    );
  }
}

class ConnectTab {
  String name;
  IconData iconData;
  Widget child;

  ConnectTab({required this.name, required this.iconData, required this.child});
}
