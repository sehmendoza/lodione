import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/list_model.dart';

class ListNotifier extends StateNotifier<List<ListModel>> {
  ListNotifier() : super([ListModel(name: 'My List', items: [])]);

  void addList(ListModel list) {
    state.length > 10 ? null : state = [...state, list];
  }

  void removeList(String listID) {
    state = state.where((list) => list.id != listID).toList();
  }

  void addItemToList(String listID, ItemModel item) {
    state = state.map((list) {
      if (list.id == listID) {
        return ListModel(
          id: list.id,
          name: list.name,
          items: [item, ...list.items],
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

  void updateItemInList(String listID, String itemID, ItemModel item) {
    state.firstWhere((list) => list.id == listID).items = state
        .firstWhere((list) => list.id == listID)
        .items
        .map((oldItem) => oldItem.id == itemID ? item : oldItem)
        .toList();
  }

  void removeItemFromList(String listID, String itemID) {
    state.firstWhere((list) => list.id == listID).items = state
        .firstWhere((list) => list.id == listID)
        .items
        .where((item) => item.id != itemID)
        .toList();
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
}

final listProvider = StateNotifierProvider<ListNotifier, List<ListModel>>(
  (ref) => ListNotifier(),
);

final selectedListProvider = StateProvider<ListModel>((ref) {
  final selectedList = ref.watch(listProvider).last;
  return selectedList;
});
