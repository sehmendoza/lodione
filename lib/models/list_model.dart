import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ListModel {
  final String id;
  final String name;
  final List<ListItem> items;

  ListModel({required this.name, required this.items}) : id = uuid.v4();

  int get totalItems => items.length;
}

class ListItem {
  final String id;
  final String name;
  String? subtitle;
  bool isDone = false;

  ListItem({required this.name, this.subtitle, required this.isDone})
      : id = uuid.v4();
}
