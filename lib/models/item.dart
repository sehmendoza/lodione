import 'package:cloud_firestore/cloud_firestore.dart';

class ItemList {
  final String id;
  final String name; // Name of the list
  final List<Item> items;

  ItemList({required this.id, required this.name, required this.items});

  factory ItemList.fromFirestore(DocumentSnapshot doc) {
    return ItemList(
      id: doc.id,
      name: doc['name'] ?? '',
      items: (doc['items'] as List<dynamic>?)
              ?.map((item) => Item.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'items': items.map((item) => item.toJson()).toList(),
      };
}

class Item {
  final String id;
  final String name;
  // Other properties...

  Item({required this.id, required this.name});

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      // Initialize other properties...
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        // Add other properties...
      };
}
