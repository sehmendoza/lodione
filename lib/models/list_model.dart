import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ListModel {
  final String id;
  final String name;
  final List<ItemModel> items;

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

class ItemModel {
  final String id;
  final String name;
  bool isDone;

  ItemModel({
    String? id,
    required this.name,
    this.isDone = false,
  }) : id = id ?? UniqueKey().toString();

  ItemModel copyWith({String? name, bool? isDone}) {
    return ItemModel(
      id: id,
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
    );
  }
}
