import 'package:get/get_state_manager/get_state_manager.dart';

import '../models/list_model.dart';

class GroupListController extends GetxController {
  List<ListModel> lists = [];

  void addToList({required String name, required List<ListItem> items}) {
    lists.add(
      ListModel(
        name: name,
        items: items,
      ),
    );
  }
}
