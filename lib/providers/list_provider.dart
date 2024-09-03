import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/item_model.dart';
import '../models/list_model.dart';

final selectedListProvider =
    StateProvider<ListModel>((ref) => ListModel(name: 'Default List'));

final listProvider =
    StateNotifierProvider<ListNotifier, List<ListModel>>((ref) {
  return ListNotifier();
});

class ListNotifier extends StateNotifier<List<ListModel>> {
  ListNotifier() : super([]);

  initList(List<ListModel> lists) {
    state = lists;
  }

  void addList(ListModel newList) async {
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

  void updateItemInList(String listID, ItemModel newItem) {
    state = state.map((list) {
      if (list.id == listID) {
        return ListModel(
          id: list.id,
          name: list.name,
          items: list.items.map((item) {
            if (item.id == newItem.id) {
              return newItem;
            }
            return item;
          }).toList(),
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

  void moveItemsToOtherList(listID, newListID) {
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
