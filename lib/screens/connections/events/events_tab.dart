import 'package:flutter/material.dart';
import 'package:lodione/const.dart';
import 'package:lodione/screens/connections/events/add_event.dart';
import 'package:lodione/widgets/buttons.dart';
import '../../../models/item_model.dart';
import '../../../models/user_model.dart';

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
          ItemModel(name: 'Sago', isDone: false, details: ''),
          ItemModel(name: 'Sago', isDone: false, details: ''),
          ItemModel(name: 'Sago', isDone: false, details: '')
        ],
        invites: [
          // UserModel(username: 'sehmendoza'),
          // UserModel(username: 'recypoli'),
        ]),
    EventModel(
        title: 'Party',
        date: '05/23/25',
        time: '09:23 AM',
        location: 'Marikina City',
        info: 'Reunion',
        requirements: [
          ItemModel(name: 'Sago', isDone: false, details: ''),
          ItemModel(name: 'Sago', isDone: false, details: ''),
          ItemModel(name: 'Sago', isDone: false, details: '')
        ],
        invites: [
          // UserModel(username: 'sehmendoza'),
          // UserModel(username: 'recypoli'),
        ]),
    EventModel(
        title: 'Party',
        date: '05/23/25',
        time: '09:23 AM',
        location: 'Marikina City',
        info: 'Reunion',
        requirements: [
          ItemModel(name: 'Sago', isDone: false, details: ''),
          ItemModel(name: 'Sago', isDone: false, details: ''),
          ItemModel(name: 'Sago', isDone: false, details: '')
        ],
        invites: [
          // UserModel(username: 'sehmendoza'),
          // UserModel(username: 'recypoli'),
        ]),
  ];

  List<String> monthName = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
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
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            // mainAxisSize: MainAxisSize.min,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                event.date.split('/')[1],
                                style:
                                    const TextStyle(color: white, fontSize: 32),
                              ),
                              Text(
                                monthName[
                                    int.parse(event.date.split('/')[0]) - 1],
                                style:
                                    const TextStyle(color: white, fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              eventDetail(Icons.event, event.title),
                              const SizedBox(
                                height: 10,
                              ),
                              eventDetail(Icons.location_on, event.location),
                              const SizedBox(
                                height: 10,
                              ),
                              eventDetail(Icons.watch_later, event.time),
                            ],
                          ),
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
                                      user.name,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButton(
                text: 'Create event',
                icon: Icons.add,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddEvent(),
                  ),
                ),
              ),
            ),
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
  List<ItemModel> requirements;
  List<UserModel> invites;

  EventModel(
      {required this.title,
      required this.date,
      required this.time,
      required this.location,
      required this.info,
      required this.requirements,
      required this.invites});
}
