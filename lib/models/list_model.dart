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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'details': details,
      'isDone': isDone,
    };
  }

  ItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        details = json['details'],
        isDone = json['isDone'];
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

  ListModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        items = (json['items'] as List)
            .map((item) => ItemModel(
                  id: item['id'],
                  name: item['name'],
                  details: item['details'],
                  isDone: item['isDone'],
                ))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
