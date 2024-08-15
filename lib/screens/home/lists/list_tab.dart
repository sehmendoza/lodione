import 'package:flutter/material.dart';
import 'package:lodione/widgets/buttons.dart';

import '../../../models/list_model.dart';
import '../../../storage/lists_list.dart';
import 'list_view.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  List<ListModel> mgaLists = lists;

  late String dropdownValue;
  late ListModel selectedList;
  @override
  void initState() {
    super.initState();
    dropdownValue = mgaLists[0].id;
    selectedList = mgaLists[0];
  }

  void selectList(id) {
    setState(() {
      selectedList = mgaLists.firstWhere((list) => list.id == id);
    });
  }

  void addItem({required String listID, required ListItem item}) {
    setState(() {
      mgaLists.firstWhere((list) => list.id == listID).items.insert(0, item);
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
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Lists: ',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 5,
                ),
                DropdownButton(
                  value: dropdownValue,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  iconSize: 18,
                  underline: Container(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(2),
                  dropdownColor: const Color.fromARGB(255, 30, 30, 30),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: mgaLists.map((ListModel listModel) {
                    return DropdownMenuItem(
                      onTap: () => selectList(listModel.id),
                      value: listModel.id,
                      child: Text(
                        listModel.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  width: 3,
                ),
                MyButton(
                  text: 'Add',
                  icon: Icons.add,
                  onPressed: addNewList,
                ),
                MyButton(
                  text: 'Share',
                  icon: Icons.folder_shared,
                  onPressed: () {},
                ),
                const Spacer(),
                PopupMenuButton(
                  iconColor: Colors.white70,
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          for (var item in selectedList.items) {
                            item.isDone = true;
                          }
                        });
                      },
                      value: 'option1',
                      child: const Row(
                        children: [
                          Icon(Icons.select_all),
                          SizedBox(
                            width: 6,
                          ),
                          Text('Select all items'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          selectedList.items
                              .removeWhere((item) => item.isDone == true);
                        });
                      },
                      value: 'optio2323',
                      child: const Row(
                        children: [
                          Icon(Icons.delete_sweep),
                          SizedBox(
                            width: 6,
                          ),
                          Text('Delete all selected items'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          for (var item in selectedList.items) {
                            item.isDone = false;
                          }
                        });
                      },
                      value: 'optio5',
                      child: const Row(
                        children: [
                          Icon(Icons.check_box_outline_blank),
                          SizedBox(
                            width: 6,
                          ),
                          Text('Unselect all items'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        // setState(() {
                        //   selectedList.items[index].subtitle == 'Sub';
                        // });
                      },
                      value: 'option2',
                      child: const Row(
                        children: [
                          Icon(Icons.drive_file_move),
                          SizedBox(
                            width: 6,
                          ),
                          Text('Move marked items to other list'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          selectedList.items.clear();
                        });
                      },
                      value: 'delete',
                      child: const Row(
                        children: [
                          Icon(Icons.delete_forever),
                          SizedBox(
                            width: 6,
                          ),
                          Text('Clear all items'),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    // Handle the selected option
                  },
                ),
              ],
            ),
          ),
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
                      item: ListItem(
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
                    item: ListItem(
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
                      setState(() {
                        mgaLists.add(
                            ListModel(name: nameController.text, items: []));
                      });
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ));
  }
}
