import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String name;
  String email;
  String username;
  final String createdAt;
  bool isPrivate;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.username,
      required this.createdAt,
      required this.isPrivate});

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? username,
    String? createdAt,
    bool? isPrivate,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      isPrivate: isPrivate ?? this.isPrivate,
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      username: data['username'] ?? '',
      createdAt: data['createdAt'] ?? '',
      isPrivate: data['isPrivate'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'createdAt': createdAt,
      'isPrivate': isPrivate,
    };
  }
}
