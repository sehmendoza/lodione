// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../models/list_model.dart';

// class ListNotifier extends StateNotifier<List<ListModel>> {
//   ListNotifier() : super([ListModel(name: 'My List', items: [])]);

//   void addList(ListModel list) {
//     state.length > 10 ? null : state = [...state, list];
//   }

//   void updateListName(String listID, String name) {
//     state.firstWhere((list) => list.id == listID).name = name;
//   }

//   void removeList(String listID) {
//     state = state.where((list) => list.id != listID).toList();
//   }

//   void addItemToList(String listID, ItemModel item) {
//     state.firstWhere((list) => list.id == listID).items.insert(0, item);
//   }

//   void updateItemInList(String listID, String itemID, ItemModel item) {
//     state.firstWhere((list) => list.id == listID).items = state
//         .firstWhere((list) => list.id == listID)
//         .items
//         .map((oldItem) => oldItem.id == itemID ? item : oldItem)
//         .toList();
//   }

//   void removeItemFromList(String listID, String itemID) {
//     state.firstWhere((list) => list.id == listID).items = state
//         .firstWhere((list) => list.id == listID)
//         .items
//         .where((item) => item.id != itemID)
//         .toList();
//   }
// }

// final listProvider = StateNotifierProvider<ListNotifier, List<ListModel>>(
//   (ref) => ListNotifier(),
// );
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for managing lists
final listProvider =
    StateNotifierProvider<ListNotifier, List<ListModel>>((ref) {
  return ListNotifier();
});

class ListNotifier extends StateNotifier<List<ListModel>> {
  ListNotifier() : super([ListModel(name: "My List", items: [])]);

  void addList(ListModel newList) {
    state = [...state, newList];
  }

  void removeList(String id) {
    state = state.where((list) => list.id != id).toList();
  }

  void addItemToList(String listID, ItemModel item) {
    state = state.map((list) {
      if (list.id == listID) {
        if (list.items.length < 100) {
          return ListModel(
            id: list.id,
            name: list.name,
            items: [item, ...list.items],
          );
        }
      }
      return list;
    }).toList();
  }

  void updateItemInList(String listID, ItemModel item) {
    state = state.map((list) {
      if (list.id == listID) {
        return ListModel(
          id: list.id,
          name: list.name,
          items: list.items
              .map((oldItem) => oldItem.id == item.id ? item : oldItem)
              .toList(),
        );
      }
      return list;
    }).toList();
  }

  void selectAll(String listID) {
    state = state.map((list) {
      if (list.id == listID) {
        return ListModel(
          id: list.id,
          name: list.name,
          items: list.items.map((item) => item.copyWith(isDone: true)).toList(),
        );
      }
      return list;
    }).toList();
  }

  void unselectAll(String listID) {
    state = state.map((list) {
      if (list.id == listID) {
        return ListModel(
          id: list.id,
          name: list.name,
          items:
              list.items.map((item) => item.copyWith(isDone: false)).toList(),
        );
      }
      return list;
    }).toList();
  }

  void clearList(listID) {
    state = state.map((list) {
      if (list.id == listID) {
        return ListModel(
          id: list.id,
          name: list.name,
          items: [],
        );
      }
      return list;
    }).toList();
  }

  void removeItemFromList(String listID, String itemID) {
    state = state.map((list) {
      if (list.id == listID) {
        return ListModel(
          id: list.id,
          name: list.name,
          items: list.items.where((item) => item.id != itemID).toList(),
        );
      }
      return list;
    }).toList();
  }

  void removeCompleted(String listID) {
    state = state.map((list) {
      if (list.id == listID) {
        return ListModel(
          id: list.id,
          name: list.name,
          items: list.items.where((item) => !item.isDone).toList(),
        );
      }
      return list;
    }).toList();
  }

  void moveItemsToOtherList(listID, itemID, newListID) {
    final items = state
        .firstWhere((list) => list.id == listID)
        .items
        .where((item) => item.isDone)
        .toList();
    final uncheckItems =
        items.map((item) => item.copyWith(isDone: false)).toList();
    state = state.map((list) {
      if (list.id == listID) {
        return ListModel(
          id: list.id,
          name: list.name,
          items: list.items.where((item) => !item.isDone).toList(),
        );
      }
      if (list.id == newListID) {
        return ListModel(
          id: list.id,
          name: list.name,
          items: [...uncheckItems, ...list.items],
        );
      }
      return list;
    }).toList();
  }
}

// Provider for the currently selected list
final selectedListProvider = StateProvider<String>((ref) {
  return ref.watch(listProvider).first.id;
});

// Model for list items
class ItemModel {
  final String id;
  String name;
  String details;
  bool isDone;

  ItemModel({
    String? id,
    required this.name,
    this.details = "",
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
