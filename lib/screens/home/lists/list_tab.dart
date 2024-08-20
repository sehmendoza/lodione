import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lodione/widgets/dialogs.dart';

import '../../../models/list_model.dart';
import 'package:lodione/providers/list_provider.dart';
import 'list_view.dart';

class ListTab extends ConsumerStatefulWidget {
  const ListTab({super.key});

  @override
  ConsumerState<ListTab> createState() => _ListTabState();
}

class _ListTabState extends ConsumerState<ListTab> {
  late String dropdownValue;
  late ListModel selectedList;

  @override
  void initState() {
    super.initState();
    dropdownValue = ref.read(listProvider).first.id;
    selectedList = ref.read(listProvider).first;
  }

  void selectList(id) {
    setState(() {
      selectedList = ref.read(listProvider).firstWhere((list) => list.id == id);
    });
  }

  void addItem({required String listID, required ItemModel item}) {
    ref
                .read(listProvider)
                .where((list) => list.id == listID)
                .first
                .items
                .length >=
            100
        ? showSimpleDialog(context, 'Cannot add more items',
            'You have reached the maximum number of items.')
        : setState(() {
            ref.read(listProvider.notifier).addItemToList(listID, item);

            itemNode.requestFocus();
            itemController.clear();
          });
  }

  FocusNode itemNode = FocusNode();
  TextEditingController itemController = TextEditingController();

  @override
  void dispose() {
    itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mgaLists = ref.watch(listProvider);

    int itemLength = selectedList.items.length;

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
          Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Lists: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      )),
                  const SizedBox(width: 5),

                  DropdownButton<String>(
                    value: dropdownValue,
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                    iconSize: 18,
                    underline: Container(
                        height: 1, color: null), // Fixed underline styling
                    borderRadius: BorderRadius.circular(2),
                    dropdownColor: const Color.fromARGB(255, 30, 30, 30),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        selectList(newValue); // Directly call selectList here
                      });
                    },
                    items: mgaLists
                        .map<DropdownMenuItem<String>>((ListModel listModel) {
                      return DropdownMenuItem<String>(
                        value: listModel.id,
                        child: Row(
                          children: [
                            Text(
                              listModel.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              padding: const EdgeInsets.all(7.5),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Text(
                                itemLength.toString(),
                                // ref
                                //     .watch(listProvider)
                                //     .firstWhere(
                                //         (list) => list.id == listModel.id)
                                //     .items
                                //     .length
                                //     .toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  const Spacer(),
                  // Popup Menu
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: Colors.white70),
                    itemBuilder: (BuildContext context) => [
                      _buildMenuItem('Add new list', Icons.add_box, addNewList),
                      _buildMenuItem('Select all items', Icons.select_all, () {
                        setState(() {
                          for (var item in selectedList.items) {
                            item.isDone = true;
                          }
                        });
                      }),
                      _buildMenuItem(
                          'Delete all selected items', Icons.delete_sweep, () {
                        setState(() {
                          selectedList.items.removeWhere((item) => item.isDone);
                        });
                      }),
                      _buildMenuItem(
                          'Unselect all items', Icons.check_box_outline_blank,
                          () {
                        setState(() {
                          for (var item in selectedList.items) {
                            item.isDone = false;
                          }
                        });
                      }),
                      _buildMenuItem('Move marked items to other list',
                          Icons.drive_file_move, () {}),
                      _buildMenuItem('Share list', Icons.share, () {}),
                      _buildMenuItem('Clear all items', Icons.delete_forever,
                          () {
                        setState(() {
                          selectedList.items.clear();
                        });
                      }),
                      _buildMenuItem('Delete list', Icons.close, () {
                        ref.read(listProvider).length == 1
                            ? showSimpleDialog(
                                context,
                                'Cannot delete "My List"',
                                'You must have at least one list.')
                            : setState(() {
                                ref
                                    .read(listProvider.notifier)
                                    .removeList(selectedList.id);
                                selectedList = ref.read(listProvider).first;
                                dropdownValue = selectedList.id;
                              });
                      }),
                    ],
                  ),
                ],
              )),
          const Divider(
            height: 0,
            color: Colors.white,
            thickness: 2,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: itemNode,
                  onSubmitted: (value) {
                    if (itemController.text.trim().isEmpty) {
                      return;
                    }
                    addItem(
                      listID: dropdownValue,
                      item: ItemModel(
                        name: itemController.text,
                        isDone: false,
                      ),
                    );
                  },
                  controller: itemController,
                  cursorColor: Colors.white54,
                  style: const TextStyle(color: Colors.white),
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.5)),
                      contentPadding: EdgeInsets.only(left: 8),
                      hintText: 'Enter item',
                      hintStyle: TextStyle(
                        color: Colors.white38,
                      )),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (itemController.text.trim().isEmpty) {
                    return;
                  }
                  addItem(
                    listID: dropdownValue,
                    item: ItemModel(
                      name: itemController.text,
                      isDone: false,
                    ),
                  );
                },
                child: const Text(
                  'add',
                  style: TextStyle(color: Colors.white70),
                ),
              )
            ],
          ),
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

  PopupMenuItem<String> _buildMenuItem(
      String text, IconData icon, VoidCallback onTap) {
    return PopupMenuItem<String>(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 6),
          Text(text),
        ],
      ),
    );
  }

  void addNewList() {
    TextEditingController nameController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.black,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(width: 2, color: Colors.white),
              ),
              title: const Text(
                'Add New List',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    maxLines: 1,
                    maxLength: 24,
                    style: const TextStyle(color: Colors.white),
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'List Name',
                      hintStyle: TextStyle(color: Colors.white54),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      nameController.text.isEmpty
                          ? null
                          : setState(() {
                              ref.read(listProvider.notifier).addList(ListModel(
                                  name: nameController.text, items: []));
                              dropdownValue = ref.read(listProvider).last.id;
                              selectedList = ref.read(listProvider).last;
                              Navigator.pop(context);
                            });
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ));
  }
}
