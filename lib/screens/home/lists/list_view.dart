import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lodione/widgets/buttons.dart';

import '../../../models/list_model.dart';
import '../../../providers/list_provider.dart';

class MyListView extends ConsumerStatefulWidget {
  const MyListView({super.key, required this.listID});

  final String listID;

  @override
  ConsumerState<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends ConsumerState<MyListView> {
  @override
  Widget build(BuildContext context) {
    final items = ref
        .watch(listProvider)
        .firstWhere((list) => list.id == widget.listID)
        .items;
    final selectedList =
        ref.watch(listProvider).firstWhere((list) => list.id == widget.listID);
    return Expanded(
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];
            return Dismissible(
              background: Container(
                color: Colors.white38,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete),
              ),
              onDismissed: (direction) {
                setState(() {
                  ref
                      .read(listProvider.notifier)
                      .removeItemFromList(selectedList.id, item.id);
                });
              },
              key: ValueKey(item.id),
              child: ListTile(
                key: ValueKey(item.id),
                leading: Checkbox(
                    value: item.isDone,
                    onChanged: (value) {
                      setState(() {
                        item.isDone = !item.isDone;
                      });
                    }),
                title: Text(
                  item.name,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: item.details == ''
                    ? null
                    : Text(
                        item.details,
                        style: const TextStyle(color: Colors.white60),
                      ),
                trailing: PopupMenuButton(
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      onTap: () {
                        showEditDialog(selectedList.id, item);
                      },
                      value: 'option1',
                      child: const Text('Edit item'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        showAddDetailDialog(selectedList.id, item);
                      },
                      value: 'option2',
                      child: Text(
                          item.details == '' ? 'Add details' : 'Edit details'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          ref
                              .read(listProvider.notifier)
                              .removeItemFromList(selectedList.id, item.id);
                        });
                      },
                      value: 'delete',
                      child: const Text('Delete'),
                    ),
                  ],
                  onSelected: (value) {
                    // Handle the selected option
                  },
                ),
              ),
            );
          }),
    );
  }

  void showEditDialog(String listID, ItemModel item) {
    TextEditingController controller = TextEditingController(text: item.name);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.white),
          ),
          title: const Center(
              child: Text('Edit item', style: TextStyle(color: Colors.white))),
          content: TextField(
            style: const TextStyle(color: Colors.white),
            controller: controller,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            MyButton(
                text: 'Save',
                icon: Icons.save,
                onPressed: () {
                  item.name = controller.text;
                  setState(() {
                    ref
                        .read(listProvider.notifier)
                        .updateItemInList(listID, item);
                  });
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  void showAddDetailDialog(String listID, ItemModel item) {
    TextEditingController controller =
        TextEditingController(text: item.details);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.white),
          ),
          title: Center(
              child: Text(item.details == '' ? 'Add details' : 'Edit details',
                  style: const TextStyle(color: Colors.white))),
          content: TextField(
            style: const TextStyle(color: Colors.white),
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter details',
              hintStyle: TextStyle(color: Colors.white60),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            MyButton(
                text: 'Save',
                icon: Icons.save,
                onPressed: () {
                  item.details = controller.text;

                  setState(() {
                    ref
                        .read(listProvider.notifier)
                        .updateItemInList(listID, item);
                  });
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }
}
