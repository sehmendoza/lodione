import 'package:cloud_firestore/cloud_firestore.dart';

enum NotificationType {
  friendRequest,
  message,
  update,
}

class NotificationModel {
  final NotificationType type;
  final String message;

  NotificationModel({
    required this.type,
    required this.message,
  });

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final type = NotificationType.values[data['type']];
    final message = data['message'];
    return NotificationModel(type: type, message: message);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'type': type.index,
      'message': message,
    };
  }
}
