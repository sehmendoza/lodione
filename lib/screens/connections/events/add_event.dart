import 'package:flutter/material.dart';
import 'package:lodione/widgets/const.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  TextEditingController reqController = TextEditingController();

  List<String> requirements = ['Fish', 'Isda'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Create Event'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.5,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.event,
                    color: Colors.white60,
                  ),
                  hintText: 'Event name',
                  hintStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Date',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shadowColor: Colors.white,
                            elevation: 3,
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                              color: white,
                            ),
                          ),
                          onPressed: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 100),
                            );
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                selectedDate = picked;
                              });
                            }
                          },
                          child: Text(
                              selectedDate.toLocal().toString().split(' ')[0]),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Time',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shadowColor: Colors.white,
                            elevation: 3,
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                              color: white,
                            ),
                          ),
                          onPressed: () async {
                            TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );
                            if (picked != null && picked != selectedTime) {
                              setState(() {
                                selectedTime = picked;
                              });
                            }
                          },
                          child: Text(' ${selectedTime.format(context)}'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.5,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.location_on,
                    color: Colors.white70,
                  ),
                  hintText: 'Enter location',
                  hintStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.5,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.info,
                    color: Colors.white70,
                  ),
                  hintText: 'Add information',
                  hintStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.white,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Requirements:',
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    ListView.builder(
                      itemCount: requirements.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4, left: 6),
                            child: Text(
                              '\u2022 ${requirements[index]}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      controller: reqController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Add requirements',
                        hintStyle: const TextStyle(color: Colors.white60),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              requirements.add(reqController.text);
                              reqController.clear();
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                          ),
                          color: Colors.white70,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  const Text('Invite friends: ',
                      style: TextStyle(
                        color: Colors.white70,
                      )),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: TextEditingController(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
