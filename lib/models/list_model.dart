import 'package:flutter/material.dart';

class ItemModel {
  final String id;
  String name;
  String details;
  bool isDone;

  ItemModel({
    String? id,
    required this.name,
    required this.details,
    this.isDone = false,
  }) : id = id ?? UniqueKey().toString();

  ItemModel copyWith({String? name, bool? isDone}) {
    return ItemModel(
      id: id,
      name: name ?? this.name,
      details: details,
      isDone: isDone ?? this.isDone,
    );
  }
}

// Model for lists
class ListModel {
  final String id;
  final String name;
  List<ItemModel> items;

  ListModel({
    String? id,
    required this.name,
    this.items = const [],
  }) : id = id ?? UniqueKey().toString();

  ListModel copyWith({String? name, List<ItemModel>? items}) {
    return ListModel(
      id: id,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }
}
