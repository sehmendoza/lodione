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
    state.firstWhere((list) => list.id == listID).items.insert(0, item);
  }

  void removeItemFromList(String listID, String itemID) {
    state.firstWhere((list) => list.id == listID).items = state
        .firstWhere((list) => list.id == listID)
        .items
        .where((item) => item.id != itemID)
        .toList();
  }
}

final listProvider = StateNotifierProvider<ListNotifier, List<ListModel>>(
  (ref) => ListNotifier(),
);
