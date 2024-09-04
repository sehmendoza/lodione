import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lodione/screens/main/waiting_screen.dart';
import 'package:lodione/services/firestore_service.dart';
import 'package:lodione/widgets/buttons.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../const.dart';
import '../../../models/item_model.dart';
import '../../../models/list_model.dart';
import '../../../providers/list_provider.dart';
import '../../../widgets/dialogs.dart';
import 'dropdown_list.dart';
import 'list_view.dart';

final FirestoreService firestoreService = FirestoreService();

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  FocusNode itemNode = FocusNode();
  TextEditingController itemController = TextEditingController();

  void addItem(listProvider, listId) {
    if (itemController.text.trim().isEmpty) {
      itemController.clear();
      return;
    }

    setState(() {
      listProvider.addItemToList(
        listId,
        ItemModel(name: itemController.text, isDone: false, details: ''),
      );
    });
    itemNode.requestFocus();
    itemController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ListProvider>(builder: (context, listProvider, child) {
      final lists = listProvider.lists;
      final selectedListId = listProvider.selectedListId;
      if (lists.isEmpty) {
        return Center(
          child: myButton1(
            'Add a new list',
            () => addNewList(listProvider),
          ),
        );
      }
      return Container(
        // width: double.infinity,
        // height: double.infinity,
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton<String>(
                    onTap: () {
                      itemNode.unfocus();
                    },
                    isExpanded: false,
                    iconSize: 30,
                    underline: const SizedBox(),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    dropdownColor: const Color.fromARGB(255, 48, 48, 48),
                    value: selectedListId,
                    hint: const Text('Select a list'),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          listProvider.selectList(newValue);
                        });
                      } else {
                        // Handle the case when 'Select a list' is chosen again, maybe do nothing or reset selection
                        addNewList(listProvider);
                      }
                    },
                    items: [
                      ...lists.map((ListModel list) {
                        return dropIt(list.id, list.name, list.items.length);
                      }),
                      DropdownMenuItem(
                        value: null,
                        child: TextButton.icon(
                          label: const Text(
                            'Add new list',
                            style: TextStyle(color: Colors.white60),
                          ),
                          icon:
                              const Icon(Icons.add_box, color: Colors.white60),
                          onPressed: null,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onOpened: () {
                    itemNode.unfocus();
                  },
                  icon: const Icon(Icons.more_vert, color: Colors.white70),
                  itemBuilder: (BuildContext context) => [
                    _buildMenuItem(
                      'Add new list',
                      Icons.add_box,
                      () => addNewList(listProvider),
                    ),
                    _buildMenuItem('Select all items', Icons.select_all, () {
                      // ref
                      //     .read(listProvider.notifier)
                      //     .selectAll(_currentList.id);
                    }),
                    _buildMenuItem(
                        'Delete all checked items', Icons.delete_sweep, () {
                      // ref
                      //     .read(listProvider.notifier)
                      //     .removeCompleted(_currentList.id);
                    }),
                    _buildMenuItem(
                        'Unselect all items', Icons.check_box_outline_blank,
                        () {
                      // ref
                      //     .read(listProvider.notifier)
                      //     .unselectAll(_currentList.id);
                    }),
                    _buildMenuItem('Move marked items to other list',
                        Icons.drive_file_move, () {
                      //    _showMoveListDialog();
                    }),
                    _buildMenuItem('Share list', Icons.share, () {
                      showMyErrorDialog(context, 'Share list',
                          'This feature is not yet available.');
                    }),
                    _buildMenuItem('Clear all items', Icons.delete_forever, () {
                      // ref
                      //     .read(listProvider.notifier)
                      //     .clearList(_currentList.id);
                    }),
                    _buildMenuItem('Delete list', Icons.close, () {
                      // _currentList.name == 'My List'
                      //     ? showMyErrorDialog(
                      //         context,
                      //         'Cannot delete "My List"',
                      //         "It's for your personal use only.")
                      //     : setState(() {
                      //         ref
                      //             .read(listProvider.notifier)
                      //             .removeList(_currentList.id);
                      //         _currentList =
                      //             ref.read(listProvider).first;
                      //       });
                    }),
                  ],
                ),
              ],
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
                    onSubmitted: (value) =>
                        addItem(listProvider, selectedListId),
                    controller: itemController,
                    cursorColor: Colors.white54,
                    style: const TextStyle(color: Colors.white),
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 8),
                        hintText: 'Enter item',
                        hintStyle: TextStyle(
                          color: Colors.white38,
                        )),
                  ),
                ),
                IconButton(
                  onPressed: () => addItem(listProvider, selectedListId),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            listProvider.selectedListId == null
                ? Expanded(
                    child: Center(
                      child: TextButton(
                        child: const Text(
                          'Select a list or add a new one',
                          style: TextStyle(color: Colors.white60),
                        ),
                        onPressed: () {
                          addNewList(listProvider);
                        },
                      ),
                    ),
                  )
                : MyListView(
                    listId: selectedListId!,
                  ),
            const Divider(
              height: 0,
              color: Colors.white,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.select_all),
                  color: Colors.white60,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.check_box_outline_blank),
                  color: Colors.white60,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_sweep),
                  color: Colors.white60,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.drive_file_move),
                  color: Colors.white60,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  color: Colors.white60,
                ),
              ],
            ),
          ],
        ),
      );
    });
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

  void addNewList(ListProvider listProvider) {
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
                              ListModel list = ListModel(
                                id: const Uuid().v4(),
                                createdBy:
                                    FirebaseAuth.instance.currentUser!.uid,
                                shareWith: [],
                                dateCreated: Timestamp.now().toString(),
                                name: nameController.text,
                                items: [],
                              );
                              //    firestoreService.createList(list);
                              listProvider.addList(list);

                              Navigator.pop(context);
                              listProvider.selectList(list.id);
                            });
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ));
  }

  // void _showMoveListDialog() async {
  //   try {
  //     final String result = await showDialog(
  //       context: context,
  //       builder: (context) => MoveListDialog(
  //         selectedListID: currentList.id,
  //         ref: ref,
  //       ),
  //     );

  //     String moveToList = result;
  //     selectList(moveToList);
  //   } catch (e) {
  //     // Do nothing
  //   }
  // }

  void showErrorDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(color: Colors.white60, width: 2),
          ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          content: Text(content, style: const TextStyle(color: Colors.white70)),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            MyButton(
                text: 'Add list',
                icon: Icons.add,
                onPressed: () {
                  Navigator.of(context).pop();
                  //  addNewList();
                }),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
