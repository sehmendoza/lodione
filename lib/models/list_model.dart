import 'package:lodione/models/item_model.dart';
import 'package:lodione/models/user_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ListModel {
  String id;
  final String name;
  final String createdBy;
  List<UserModel> shareWith;
  final String dateCreated;
  List<ItemModel> items;

  void addItem(ItemModel item) {
    items.add(item);
  }

  ListModel({
    this.id = '',
    required this.name,
    this.items = const [],
    this.shareWith = const [],
    this.createdBy = '',
    this.dateCreated = '',
  });

  ListModel copyWith({
    String? name,
    String? createdBy,
    String? dateCreated,
    List<UserModel>? shareWith,
    List<ItemModel>? items,
  }) {
    return ListModel(
      id: id,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      dateCreated: dateCreated ?? this.dateCreated,
      shareWith: shareWith ?? this.shareWith,
      items: items ?? this.items,
    );
  }

  factory ListModel.fromFirestore(Map<String, dynamic> json) {
    return ListModel(
      id: json['id'] as String? ?? uuid.v4(),
      name: json['name'] as String? ?? '',
      createdBy: json['createdBy'] as String? ?? '',
      dateCreated: json['dateCreated'] as String? ?? '',
      shareWith: (json['shareWith'] as List<dynamic>?)
              ?.map((user) => UserModel.fromFirestore(user))
              .toList() ??
          [],
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => ItemModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'createdBy': createdBy,
      'dateCreated': dateCreated,
      'shareWith': shareWith.map((user) => user.toFirestore()).toList(),
      'items': items.map((item) => item.toFirestore()).toList(),
    };
  }
}
