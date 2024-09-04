import 'package:flutter/material.dart';

void showMyErrorDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(color: Colors.white60, width: 2),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(content, style: const TextStyle(color: Colors.white70)),
        actionsAlignment: MainAxisAlignment.end,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}

Widget myAlertDialog(context, text) {
  return AlertDialog(
    elevation: 5,
    shadowColor: Colors.red,
    title: const Text('Oops!', style: TextStyle(fontWeight: FontWeight.bold)),
    content: Text(text),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('OK'),
      ),
    ],
  );
}
