import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/list_model.dart';
import 'package:lodione/providers/list_provider.dart';
import 'list_view.dart';

class ListTab extends ConsumerStatefulWidget {
  const ListTab({super.key});

  @override
  ConsumerState<ListTab> createState() => _ListTabState();
}

class _ListTabState extends ConsumerState<ListTab> {
  @override
  Widget build(BuildContext context) {
    final allList = ref.watch(listProvider);
    final selectedList = ref.watch(selectedListProvider);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildListSelector(allList, ref, context, selectedList),
          const Divider(
            height: 0,
            color: Colors.white,
            thickness: 2,
          ),
          _buildAddItemForm(ref, selectedList),
          const SizedBox(
            height: 3,
          ),
          MyListView(
            selectedList: selectedList,
          )
        ],
      ),
    );
  }

  Widget _buildListSelector(List<ListModel> allList, WidgetRef ref,
      BuildContext context, ListModel selectedList) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          const Text('Lists: ',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(width: 5),
          DropdownButton<ListModel>(
            borderRadius: BorderRadius.circular(8),
            dropdownColor: const Color.fromARGB(255, 32, 32, 32),
            value: selectedList,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            onChanged: (newValue) =>
                ref.read(selectedListProvider.notifier).state = newValue!,
            items: allList.map<DropdownMenuItem<ListModel>>((list) {
              return DropdownMenuItem<ListModel>(
                value: list,
                child: _buildDropdownItem(list),
              );
            }).toList(),
            underline: Container(
              color: null,
            ),
          ),
          const Spacer(),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white70),
            onSelected: (value) =>
                _handleMenuSelection(value, ref, selectedList, context),
            itemBuilder: (BuildContext context) => [
              _buildMenuItem('Add new list', Icons.add_box),
              _buildMenuItem('Select all items', Icons.select_all),
              _buildMenuItem('Delete all selected items', Icons.delete_sweep),
              _buildMenuItem(
                  'Unselect all items', Icons.check_box_outline_blank),
              _buildMenuItem(
                  'Move marked items to other list', Icons.drive_file_move),
              _buildMenuItem('Share list', Icons.share),
              _buildMenuItem('Clear all items', Icons.delete_forever),
              _buildMenuItem('Delete list', Icons.close),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddItemForm(WidgetRef ref, ListModel selectedList) {
    final itemController = TextEditingController();
    final itemNode = FocusNode();

    return Row(
      children: [
        Expanded(
          child: TextField(
            focusNode: itemNode,
            controller: itemController,
            onSubmitted: (value) {
              _addItem(ref, itemController, selectedList);
              itemNode.requestFocus();
            },
            cursorColor: Colors.white54,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.5)),
              contentPadding: EdgeInsets.only(left: 8),
              hintText: 'Enter item',
              hintStyle: TextStyle(color: Colors.white38),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            _addItem(ref, itemController, selectedList);
            itemNode.requestFocus();
          },
          child: const Text('add', style: TextStyle(color: Colors.white70)),
        )
      ],
    );
  }

  void _addItem(
      WidgetRef ref, TextEditingController controller, ListModel selectedList) {
    if (controller.text.trim().isEmpty) return;
    ref.read(listProvider.notifier).addItemToList(
          selectedList.id,
          ItemModel(name: controller.text, isDone: false),
        );
    // ref.read(selectedListProvider.notifier).state = selectedList.copyWith();
    controller.clear();
  }

  void _handleMenuSelection(String value, WidgetRef ref, ListModel selectedList,
      BuildContext context) {
    switch (value) {
      case 'Add new list':
        _showAddListDialog(ref, context);
        break;
      case 'Select all items':
        ref.read(listProvider.notifier).selectAll(selectedList.id);
        break;
      case 'Delete all selected items':
        ref.read(listProvider.notifier).removeCompleted(selectedList.id);
        break;
      case 'Unselect all items':
        ref.read(listProvider.notifier).unselectAll(selectedList.id);
        break;
      // Add more cases for other menu items
    }
  }

  void _showAddListDialog(WidgetRef ref, BuildContext context) {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(color: Colors.white, width: 2)),
        title: const Text('Add New List',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: nameController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'List Name',
            hintStyle: TextStyle(color: Colors.white54),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white60)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white60, width: 2)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                ref
                    .read(listProvider.notifier)
                    .addList(ListModel(name: nameController.text, items: []));
                Navigator.pop(context);
              }
            },
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem(ListModel list) {
    return Row(
      children: [
        Text(list.name, style: const TextStyle(color: Colors.white)),
        Container(
          margin: const EdgeInsets.only(left: 6),
          padding: const EdgeInsets.all(7.5),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Text(
            list.items.length.toString(),
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(String text, IconData icon) {
    return PopupMenuItem<String>(
      value: text,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 6),
          Text(text),
        ],
      ),
    );
  }
}
