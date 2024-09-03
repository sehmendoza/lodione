import 'package:flutter/material.dart';
import 'package:lodione/widgets/buttons.dart';
import 'package:provider/provider.dart';
import '../../../models/item_model.dart';
import '../../../models/list_model.dart';
import '../../../providers/new_list_provider.dart';

class MyListView extends StatefulWidget {
  const MyListView({super.key, required this.list});

  final ListModel list;

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  @override
  Widget build(BuildContext context) {
    List<ItemModel> items = widget.list.items;
    var listsProvider = Provider.of<ListProvider>(context, listen: false);
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
                  listsProvider.removeItemFromList(widget.list.id, item.id);
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
                        showEditDialog(widget.list.id, item, listsProvider);
                      },
                      value: 'option1',
                      child: const Text('Edit item'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        showAddDetailDialog(
                            widget.list.id, item, listsProvider);
                      },
                      value: 'option2',
                      child: Text(
                          item.details == '' ? 'Add details' : 'Edit details'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          listsProvider.removeItemFromList(
                              widget.list.id, item.id);
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

  void showEditDialog(
      String listID, ItemModel item, ListProvider listProvider) {
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
                    listProvider.updateItemInList(listID, item);
                  });
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  void showAddDetailDialog(
      String listID, ItemModel item, ListProvider listProvider) {
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
                    listProvider.updateItemInList(listID, item);
                  });
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }
}
