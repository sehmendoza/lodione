import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lodione/providers/new_list_provider.dart';
import 'package:lodione/services/firestore_service.dart';
import 'package:lodione/widgets/buttons.dart';
import 'package:provider/provider.dart';
import '../../../models/item_model.dart';
import '../../../models/list_model.dart';
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
  @override
  void dispose() {
    itemController.dispose();
    super.dispose();
  }

  void addItem({required String listID, required ItemModel item}) {
    firestoreService.addItemToList(listID, item);
  }

  @override
  Widget build(BuildContext context) {
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
      child: Consumer<ListProvider>(
        builder: (context, listsProvider, child) {
          var selectedList = listsProvider.selectedList;
          return Column(
            children: [
              Row(
                children: [
                  DropdownButton<ListModel>(
                    dropdownColor: const Color.fromARGB(255, 48, 48, 48),
                    value: listsProvider.selectedList,
                    hint: const Text('Select a list'),
                    onChanged: (ListModel? newValue) {
                      if (newValue != null) {
                        listsProvider.selectList(newValue);
                      } else {
                        // Handle the case when 'Select a list' is chosen again, maybe do nothing or reset selection
                        listsProvider.selectList(
                            null); // Uncomment if you want to explicitly handle this case
                      }
                    },
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('Select a list'),
                      ),
                      ...listsProvider.lists.map((ListModel list) {
                        return dropIt(list);
                      }),
                    ],
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
                        () => addNewList(listsProvider),
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
                      _buildMenuItem('Clear all items', Icons.delete_forever,
                          () {
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
              const SizedBox(
                height: 3,
              ),
              if (listsProvider.selectedList != null)
                MyListView(
                  list: selectedList!,
                ),
              // DropdownList(
              //   currentValue: currentList.id,
              //   lists: list,
              // ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: itemNode,
                      onSubmitted: (value) {
                        if (itemController.text.trim().isEmpty) {
                          return;
                        }
                        // addItem(
                        //   listID: _currentList.id,
                        //   item: ItemModel(
                        //       name: itemController.text,
                        //       isDone: false,
                        //       details: ''),
                        // );
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
                  IconButton(
                    onPressed: () {
                      if (itemController.text.trim().isEmpty) {
                        itemController.clear();
                        return;
                      }
                      print(selectedList!.id);
                      print(listsProvider.selectedList!.name);
                      // addItem(
                      //   listID: currentList.id,
                      //   item: ItemModel(
                      //       name: itemController.text,
                      //       isDone: false,
                      //       details: ''),
                      // );
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    //    StreamBuilder<QuerySnapshot>(
    //       stream: FirebaseFirestore.instance
    //           .collection('users')
    //           .doc(currentUser.uid)
    //           .collection('lists')
    //           .snapshots(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return const Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         } else if (snapshot.hasError) {
    //           return Center(
    //             child: Text(
    //               'Error: ${snapshot.error}',
    //               style: const TextStyle(color: Colors.white),
    //             ),
    //           );
    //         } else if (snapshot.hasData) {
    //           var data = snapshot.data!.docs;
    //           List<ListModel> list = data
    //               .map((list) => ListModel.fromFirestore(
    //                   list.data() as Map<String, dynamic>))
    //               .toList()
    //             ..sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    //           ListModel currentList = list.last;

    //           return Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.only(left: 8.0),
    //                 child: Row(
    //                   //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   //  crossAxisAlignment: CrossAxisAlignment.center,
    //                   //   mainAxisSize: MainAxisSize.min,
    //                   children: [
    //                     DropdownList(
    //                       currentValue: currentList.id,
    //                       lists: list,
    //                     ),

    //                     // Popup Menu
    //                     const Spacer(),
    //                     PopupMenuButton<String>(
    //                       onOpened: () {
    //                         itemNode.unfocus();
    //                       },
    //                       icon: const Icon(Icons.more_vert,
    //                           color: Colors.white70),
    //                       itemBuilder: (BuildContext context) => [
    //                         _buildMenuItem(
    //                             'Add new list', Icons.add_box, addNewList),
    //                         _buildMenuItem('Select all items', Icons.select_all,
    //                             () {
    //                           // ref
    //                           //     .read(listProvider.notifier)
    //                           //     .selectAll(_currentList.id);
    //                         }),
    //                         _buildMenuItem(
    //                             'Delete all checked items', Icons.delete_sweep,
    //                             () {
    //                           // ref
    //                           //     .read(listProvider.notifier)
    //                           //     .removeCompleted(_currentList.id);
    //                         }),
    //                         _buildMenuItem('Unselect all items',
    //                             Icons.check_box_outline_blank, () {
    //                           // ref
    //                           //     .read(listProvider.notifier)
    //                           //     .unselectAll(_currentList.id);
    //                         }),
    //                         _buildMenuItem('Move marked items to other list',
    //                             Icons.drive_file_move, () {
    //                           //    _showMoveListDialog();
    //                         }),
    //                         _buildMenuItem('Share list', Icons.share, () {
    //                           showMyErrorDialog(context, 'Share list',
    //                               'This feature is not yet available.');
    //                         }),
    //                         _buildMenuItem(
    //                             'Clear all items', Icons.delete_forever, () {
    //                           // ref
    //                           //     .read(listProvider.notifier)
    //                           //     .clearList(_currentList.id);
    //                         }),
    //                         _buildMenuItem('Delete list', Icons.close, () {
    //                           // _currentList.name == 'My List'
    //                           //     ? showMyErrorDialog(
    //                           //         context,
    //                           //         'Cannot delete "My List"',
    //                           //         "It's for your personal use only.")
    //                           //     : setState(() {
    //                           //         ref
    //                           //             .read(listProvider.notifier)
    //                           //             .removeList(_currentList.id);
    //                           //         _currentList =
    //                           //             ref.read(listProvider).first;
    //                           //       });
    //                         }),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               const Divider(
    //                 height: 0,
    //                 color: Colors.white,
    //                 thickness: 2,
    //               ),
    //               const SizedBox(
    //                 height: 3,
    //               ),
    //               MyListView(
    //                 list: currentList,
    //               ),
    //               const SizedBox(
    //                 height: 3,
    //               ),
    //               const Divider(
    //                 height: 0,
    //                 color: Colors.white,
    //                 thickness: 2,
    //               ),
    //               Row(
    //                 children: [
    //                   Expanded(
    //                     child: TextField(
    //                       focusNode: itemNode,
    //                       onSubmitted: (value) {
    //                         if (itemController.text.trim().isEmpty) {
    //                           return;
    //                         }
    //                         // addItem(
    //                         //   listID: _currentList.id,
    //                         //   item: ItemModel(
    //                         //       name: itemController.text,
    //                         //       isDone: false,
    //                         //       details: ''),
    //                         // );
    //                       },
    //                       controller: itemController,
    //                       cursorColor: Colors.white54,
    //                       style: const TextStyle(color: Colors.white),
    //                       textCapitalization: TextCapitalization.sentences,
    //                       decoration: const InputDecoration(
    //                           focusedBorder: UnderlineInputBorder(
    //                               borderSide: BorderSide(
    //                                   color: Colors.white, width: 1.5)),
    //                           contentPadding: EdgeInsets.only(left: 8),
    //                           hintText: 'Enter item',
    //                           hintStyle: TextStyle(
    //                             color: Colors.white38,
    //                           )),
    //                     ),
    //                   ),
    //                   IconButton(
    //                     onPressed: () {
    //                       if (itemController.text.trim().isEmpty) {
    //                         itemController.clear();
    //                         return;
    //                       }
    //                       print(currentList.id);
    //                       print(currentList.name);
    //                       // addItem(
    //                       //   listID: currentList.id,
    //                       //   item: ItemModel(
    //                       //       name: itemController.text,
    //                       //       isDone: false,
    //                       //       details: ''),
    //                       // );
    //                     },
    //                     icon: const Icon(
    //                       Icons.add,
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   IconButton(
    //                     onPressed: () {},
    //                     icon: const Icon(Icons.select_all),
    //                     color: Colors.white60,
    //                   ),
    //                   IconButton(
    //                     onPressed: () {},
    //                     icon: const Icon(Icons.check_box_outline_blank),
    //                     color: Colors.white60,
    //                   ),
    //                   IconButton(
    //                     onPressed: () {},
    //                     icon: const Icon(Icons.delete_sweep),
    //                     color: Colors.white60,
    //                   ),
    //                   IconButton(
    //                     onPressed: () {},
    //                     icon: const Icon(Icons.drive_file_move),
    //                     color: Colors.white60,
    //                   ),
    //                   IconButton(
    //                     onPressed: () {},
    //                     icon: const Icon(Icons.share),
    //                     color: Colors.white60,
    //                   ),
    //                   IconButton(
    //                     onPressed: () {},
    //                     icon: const Icon(Icons.delete),
    //                     color: Colors.white60,
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           );
    //         } else {
    //           return const Text('Loading...');
    //         }
    //       }),
    // );
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
                              //    listProvider.selectList(listProvider.lists.last);
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
