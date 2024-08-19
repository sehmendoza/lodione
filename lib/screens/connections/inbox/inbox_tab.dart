import 'package:flutter/material.dart';

class Email {
  final String sender;
  final String subject;
  final String body;

  Email({required this.sender, required this.subject, required this.body});
}

class InboxTab extends StatefulWidget {
  const InboxTab({super.key});

  @override
  State<InboxTab> createState() => _InboxTabState();
}

class _InboxTabState extends State<InboxTab> {
  List<Email> emails = []; // List to store emails

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      body: ListView.builder(
        itemCount: emails.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(emails[index].subject),
            subtitle: Text(emails[index].sender),
            onTap: () {
              // Open email details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmailDetailsPage(email: emails[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new email
          setState(() {
            emails.add(
              Email(
                sender: 'John Doe',
                subject: 'New Email',
                body: 'This is the body of the email.',
              ),
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EmailDetailsPage extends StatelessWidget {
  final Email email;

  const EmailDetailsPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email.subject),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('From: ${email.sender}'),
          const SizedBox(height: 8),
          Text(email.body),
        ],
      ),
    );
  }
}
