import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/list_model.dart';

class ListNotifier extends StateNotifier<List<ListModel>> {
  ListNotifier() : super([ListModel(name: 'My List', items: [])]);

  void addList(ListModel list) {
    state.length > 10 ? null : state = [...state, list];
  }

  void removeList(String id) {
    state = state.where((list) => list.id != id).toList();
  }

  void addItemToList(ListModel list, ItemModel item) {
    state = state.map((oldList) {
      if (oldList.id == list.id) {
        if (oldList.items.length < 100) {
          return ListModel(
            id: list.id,
            name: list.name,
            items: [item, ...list.items],
          );
        }
      }
      return oldList;
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

  void removeSelected(String listID) {
    state = state.map((list) {
      if (list.id == listID) {
        return ListModel(
          id: list.id,
          name: list.name,
          items: list.items.where((item) => item.isDone == false).toList(),
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
}

final listProvider = StateNotifierProvider<ListNotifier, List<ListModel>>(
  (ref) => ListNotifier(),
);

final selectedListProvider = StateProvider<ListModel>((ref) {
  return ref.watch(listProvider).first;
});
