import 'package:lodione/models/item_model.dart';
import 'package:lodione/models/user_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ListModel {
  final String id;
  final String name;
  final List<ItemModel> items;
  final List<UserModel> users;

  ListModel({
    String? id,
    required this.name,
    this.items = const [],
    this.users = const [],
  }) : id = id ?? uuid.v4();

  ListModel copyWith({
    String? name,
    List<ItemModel>? items,
    List<UserModel>? users,
  }) {
    return ListModel(
      id: id,
      name: name ?? this.name,
      items: items ?? this.items,
      users: users ?? this.users,
    );
  }

  factory ListModel.fromFirestore(Map<String, dynamic> json) {
    return ListModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => ItemModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      users: (json['users'] as List<dynamic>?)
              ?.map((user) => UserModel.fromJson(user as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'items': items.map((item) => item.toFirestore()).toList(),
      'users': users.map((user) => user.toFirestore()).toList(),
    };
  }
}
