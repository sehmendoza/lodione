import 'package:flutter/material.dart';
import 'package:lodione/services/list_service.dart';

import '../models/list_model.dart';

class ListProvider extends ChangeNotifier {
  final ListService _listService = ListService();

  List<ListModel> _lists = [];
  List<ListModel> get lists => _lists;
  Stream<List<ListModel>> get listStream => _listService.streamLists();
  void fetchLists() async {
    _lists = await _listService.fetchList();
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
}
