import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String description;
  bool isCompleted;
  final String ownerId; // User ID of the task owner
  final List<String> sharedWith; // List of user IDs this task is shared with

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    required this.ownerId,
    this.sharedWith = const [],
  });

  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      title: data['title'] ?? 'No Title',
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      ownerId: data['ownerId'] ?? '',
      sharedWith: List<String>.from(data['sharedWith'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'ownerId': ownerId,
      'sharedWith': sharedWith,
    };
  }
}
