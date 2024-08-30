import 'package:uuid/uuid.dart';

const uuid = Uuid();

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
  }) : id = id ?? uuid.v4();

  ItemModel copyWith({String? name, String? details, bool? isDone}) {
    return ItemModel(
      id: id,
      name: name ?? this.name,
      details: details ?? this.details,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'details': details,
      'isDone': isDone,
    };
  }

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      details: json['details'],
      isDone: json['isDone'],
    );
  }
}
