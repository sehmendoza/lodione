import 'package:flutter/material.dart';
import 'package:lodione/const.dart';
import 'package:lodione/screens/connections/events/add_event.dart';

import '../../../models/list_model.dart';
import '../contacts_tab.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({super.key});

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  List<EventModel> events = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: black),
      child: Column(
        mainAxisAlignment:
            events.isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder: (context, index) {
                var event = events[index];
                return ExpansionTile(
                  title: Text(event.title),
                );
              }),
          TextButton.icon(
            style: myButtonStyle,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddEvent(),
              ),
            ),
            label: const Text("Create event"),
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}

class EventModel {
  final String title;
  final String date;
  final String time;
  final String location;
  final String info;
  final List<ListItem> requirements;
  final List<UserModel> invites;

  EventModel(
      {required this.title,
      required this.date,
      required this.time,
      required this.location,
      required this.info,
      required this.requirements,
      required this.invites});
}
