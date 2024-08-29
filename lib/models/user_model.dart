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

  UserModel copyWith({String? username}) {
    return UserModel(
      id: id,
      username: username ?? this.username,
      name: name,
      email: email,
      createdAt: createdAt,
      isPrivate: isPrivate,
    );
  }

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
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
      'name': name,
      'email': email,
      'username': username,
      'createdAt': createdAt,
      'isPrivate': isPrivate,
    };
  }
}
