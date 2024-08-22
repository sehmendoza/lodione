import 'package:flutter/material.dart';

import '../screens/connections/contacts/contacts_tab.dart';

class NewListModel {
  final String id;
  final String name;
  final List<NewItemModel> items;
  final List<UserModel> shareToUsers;

  NewListModel(
      {required this.name, required this.items, required this.shareToUsers})
      : id = UniqueKey().toString();

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  // Factory constructor to create from Firestore data
  factory NewListModel.fromMap(Map<String, dynamic> data) {
    return NewListModel(
      name: data['name'],
      items: (data['items'] as List<dynamic>)
          .map((item) => NewItemModel.fromMap(item))
          .toList(),
      shareToUsers: (data['shareToUsers'] as List<dynamic>)
          .map((user) => UserModel.fromMap(user))
          .toList(),
    );
  }
}

class NewItemModel {
  final String id;
  final String name;
  final String details;
  final bool isDone;

  NewItemModel(
      {required this.name, required this.details, required this.isDone})
      : id = UniqueKey().toString();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'details': details,
    };
  }

  factory NewItemModel.fromMap(Map<String, dynamic> data) {
    return NewItemModel(
      name: data['name'],
      details: data['details'],
      isDone: data['isDone'],
    );
  }
}
