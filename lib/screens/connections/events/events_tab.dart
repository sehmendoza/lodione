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
  List<EventModel> events = [
    EventModel(
        title: 'Party',
        date: '05/27/24',
        time: '09:23 AM',
        location: 'Marikina City',
        info: 'Reunion',
        requirements: [
          ListItem(name: 'Sago', isDone: false),
          ListItem(name: 'Sago', isDone: false),
          ListItem(name: 'Sago', isDone: false)
        ],
        invites: [
          UserModel(username: 'sehmendoza'),
          UserModel(username: 'recypoli'),
        ]),
    EventModel(
        title: 'Party',
        date: '05/23/25',
        time: '09:23 AM',
        location: 'Marikina City',
        info: 'Reunion',
        requirements: [
          ListItem(name: 'Sago', isDone: false),
          ListItem(name: 'Sago', isDone: false),
          ListItem(name: 'Sago', isDone: false)
        ],
        invites: [
          UserModel(username: 'sehmendoza'),
          UserModel(username: 'recypoli'),
        ]),
    EventModel(
        title: 'Party',
        date: '05/23/25',
        time: '09:23 AM',
        location: 'Marikina City',
        info: 'Reunion',
        requirements: [
          ListItem(name: 'Sago', isDone: false),
          ListItem(name: 'Sago', isDone: false),
          ListItem(name: 'Sago', isDone: false)
        ],
        invites: [
          UserModel(username: 'sehmendoza'),
          UserModel(username: 'recypoli'),
        ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: black),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: events.isEmpty
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  var event = events[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      title: Column(
                        children: [
                          eventDetail(Icons.event, event.title),
                          const SizedBox(
                            height: 10,
                          ),
                          eventDetail(Icons.location_on, event.location),
                          const SizedBox(
                            height: 10,
                          ),
                          eventDetail(Icons.watch_later,
                              '${event.date} - ${event.time}'),
                        ],
                      ),
                      children: [
                        const Row(
                          children: [
                            Text(
                              '  Requirements:',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: event.requirements.length,
                            itemBuilder: (context, index) {
                              var req = event.requirements[index];
                              return Row(
                                children: [
                                  Checkbox(
                                      value: req.isDone,
                                      onChanged: (value) {
                                        setState(() {
                                          req.isDone = value ?? false;
                                        });
                                      }),
                                  Text(
                                    req.name,
                                    style: const TextStyle(color: white),
                                  ),
                                ],
                              );
                            }),
                        const Row(
                          children: [
                            Text(
                              '  Invited:',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: event.invites.length,
                            itemBuilder: (context, index) {
                              var user = event.invites[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      user.username,
                                      style: const TextStyle(color: white),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  );
                },
              ),
            ),
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
      ),
    );
  }
}

Widget eventDetail(icon, text) {
  return Row(
    children: [
      Icon(
        icon,
        color: Colors.white70,
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 21,
        ),
      ),
    ],
  );
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
