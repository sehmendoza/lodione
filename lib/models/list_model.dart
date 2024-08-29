import 'package:lodione/models/item_model.dart';
import 'package:lodione/models/user_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ListModel {
  final String id;
  final String name;
  List<ItemModel> items;
  List<UserModel> users;

  ListModel({
    String? id,
    required this.name,
    this.items = const [],
    this.users = const [],
  }) : id = id ?? uuid.v4();

  ListModel copyWith(
      {String? name, List<ItemModel>? items, List<UserModel>? users}) {
    return ListModel(
      id: id,
      name: name ?? this.name,
      items: items ?? this.items,
      users: users ?? this.users,
    );
  }

  ListModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        users = (json['users'] as List)
            .map((user) => UserModel(
                  id: user['id'],
                  name: user['name'],
                  email: user['email'],
                  username: user['username'],
                  createdAt: user['createdAt'],
                  isPrivate: user['isPrivate'],
                ))
            .toList(),
        items = (json['items'] as List)
            .map((item) => ItemModel(
                  id: item['id'],
                  name: item['name'],
                  details: item['details'],
                  isDone: item['isDone'],
                ))
            .toList();

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'items': items.map((item) => item.toFirestore()).toList(),
      'users': users.map((user) => user.toFirestore()).toList(),
    };
  }
}
