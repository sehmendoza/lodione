import 'package:flutter/material.dart';

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
                        height: 1,
                        color: Colors.white), // Fixed underline styling
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
                        child: Text(listModel.name,
                            style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                  ),

                  // // Button Group
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     MyButton(
                  //       text: 'Add',
                  //       icon: Icons.add,
                  //       onPressed: addNewList,
                  //     ),
                  //     const SizedBox(width: 3),
                  //     MyButton(
                  //       text: 'Share',
                  //       icon: Icons.share,
                  //       onPressed:
                  //           () {}, // Placeholder for future implementation
                  //     ),
                  //   ],
                  // ),
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
                    maxLength: 32,
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
