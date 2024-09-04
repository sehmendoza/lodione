import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lodione/services/list_service.dart';

import '../models/item_model.dart';
import '../models/list_model.dart';

class ListProvider extends ChangeNotifier {
  final ListService _listService = ListService();

  ListProvider() {
    fetchLists();
  }

  List<ListModel> _lists = [];
  List<ListModel> get lists => _lists;

  String? _selectedListId;

  String? get selectedListId => _selectedListId;

  Stream<List<ListModel>> get listStream => _listService.streamLists();

  void fetchLists() async {
    _lists = await _listService.fetchList();
    notifyListeners();
  }

  List<ItemModel> getListItems(String listId) {
    ListModel list = _lists.firstWhere((list) => list.id == listId);
    return list.items;
  }

  void selectList(String listId) {
    _selectedListId = listId;
    notifyListeners();
  }

  void addList(ListModel list) {
    _lists.add(list);
    _listService.addList(list);
    notifyListeners();
  }

  void removeList(ListModel list) {
    _lists.remove(list);
    _listService.removeList(list);
    notifyListeners();
  }

  void updateList(ListModel list) {
    ListModel oldList = _lists.firstWhere((list) => list.id == list.id);
    _lists[_lists.indexOf(oldList)] = list;
    _listService.updateList(list);
    notifyListeners();
  }

  void addItemToList(String listId, ItemModel item) {
    ListModel list = _lists.firstWhere((list) => list.id == listId);
    list.items.add(item);
    _listService.addItemToList(listId, item);
    notifyListeners();
  }

  void removeItemFromList(String listId, String itemId) {
    ListModel list = _lists.firstWhere((list) => list.id == listId);
    ItemModel item = list.items.firstWhere((item) => item.id == itemId);
    list.items.remove(item);
    _listService.removeItemFromList(listId, itemId);
    notifyListeners();
  }

  void updateItemInList(String listId, ItemModel item) {
    ListModel list = _lists.firstWhere((list) => list.id == listId);
    ItemModel oldItem = list.items.firstWhere((item) => item.id == item.id);
    list.items[list.items.indexOf(oldItem)] = item;
    _listService.updateItemInList(listId, item);
    notifyListeners();
  }
}
