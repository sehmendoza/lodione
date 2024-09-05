// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:lodione/screens/main/waiting_screen.dart';
// import 'package:lodione/services/firestore_service.dart';
// import 'package:lodione/widgets/buttons.dart';
// import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';
// import '../../../const.dart';
// import '../../../models/item_model.dart';
// import '../../../models/list_model.dart';
// import '../../../providers/list_provider.dart';
// import '../../../widgets/dialogs.dart';
// import 'dropdown_list.dart';
// import 'list_view.dart';

// final FirestoreService firestoreService = FirestoreService();

// class ListTab extends StatefulWidget {
//   const ListTab({super.key});

//   @override
//   State<ListTab> createState() => _ListTabState();
// }

// class _ListTabState extends State<ListTab> {
//   FocusNode itemNode = FocusNode();
//   TextEditingController itemController = TextEditingController();

//   void addItem(listProvider, listId) {
//     if (itemController.text.trim().isEmpty) {
//       itemController.clear();
//       return;
//     }

//     setState(() {
//       listProvider.addItemToList(
//         listId,
//         ItemModel(name: itemController.text, isDone: false, details: ''),
//       );
//     });
//     itemNode.requestFocus();
//     itemController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ListProvider>(builder: (context, listProvider, child) {
//       final lists = listProvider.lists;
//       final selectedListId = listProvider.selectedListId;
//       if (lists.isEmpty) {
//         return Center(
//           child: myButton1(
//             'Add a new list',
//             () => addNewList(listProvider),
//           ),
//         );
//       }
//       return Container(
//         // width: double.infinity,
//         // height: double.infinity,
//         margin: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: Colors.white,
//             width: 2,
//           ),
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: DropdownButton<String>(
//                     onTap: () {
//                       itemNode.unfocus();
//                     },
//                     isExpanded: false,
//                     iconSize: 30,
//                     underline: const SizedBox(),
//                     style: const TextStyle(color: Colors.white, fontSize: 18),
//                     dropdownColor: const Color.fromARGB(255, 48, 48, 48),
//                     value: selectedListId,
//                     hint: const Text('Select a list'),
//                     onChanged: (String? newValue) {
//                       if (newValue != null) {
//                         setState(() {
//                           listProvider.selectList(newValue);
//                         });
//                       } else {
//                         // Handle the case when 'Select a list' is chosen again, maybe do nothing or reset selection
//                         addNewList(listProvider);
//                       }
//                     },
//                     items: [
//                       ...lists.map((ListModel list) {
//                         return dropIt(list.id, list.name, list.items.length);
//                       }),
//                       DropdownMenuItem(
//                         value: null,
//                         child: TextButton.icon(
//                           label: const Text(
//                             'Add new list',
//                             style: TextStyle(color: Colors.white60),
//                           ),
//                           icon:
//                               const Icon(Icons.add_box, color: Colors.white60),
//                           onPressed: null,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Spacer(),
//                 PopupMenuButton<String>(
//                   onOpened: () {
//                     itemNode.unfocus();
//                   },
//                   icon: const Icon(Icons.more_vert, color: Colors.white70),
//                   itemBuilder: (BuildContext context) => [
//                     _buildMenuItem(
//                       'Add new list',
//                       Icons.add_box,
//                       () => addNewList(listProvider),
//                     ),
//                     _buildMenuItem('Select all items', Icons.select_all, () {
//                       // ref
//                       //     .read(listProvider.notifier)
//                       //     .selectAll(_currentList.id);
//                     }),
//                     _buildMenuItem(
//                         'Delete all checked items', Icons.delete_sweep, () {
//                       // ref
//                       //     .read(listProvider.notifier)
//                       //     .removeCompleted(_currentList.id);
//                     }),
//                     _buildMenuItem(
//                         'Unselect all items', Icons.check_box_outline_blank,
//                         () {
//                       // ref
//                       //     .read(listProvider.notifier)
//                       //     .unselectAll(_currentList.id);
//                     }),
//                     _buildMenuItem('Move marked items to other list',
//                         Icons.drive_file_move, () {
//                       //    _showMoveListDialog();
//                     }),
//                     _buildMenuItem('Share list', Icons.share, () {
//                       showMyErrorDialog(context, 'Share list',
//                           'This feature is not yet available.');
//                     }),
//                     _buildMenuItem('Clear all items', Icons.delete_forever, () {
//                       // ref
//                       //     .read(listProvider.notifier)
//                       //     .clearList(_currentList.id);
//                     }),
//                     _buildMenuItem('Delete list', Icons.close, () {
//                       // _currentList.name == 'My List'
//                       //     ? showMyErrorDialog(
//                       //         context,
//                       //         'Cannot delete "My List"',
//                       //         "It's for your personal use only.")
//                       //     : setState(() {
//                       //         ref
//                       //             .read(listProvider.notifier)
//                       //             .removeList(_currentList.id);
//                       //         _currentList =
//                       //             ref.read(listProvider).first;
//                       //       });
//                     }),
//                   ],
//                 ),
//               ],
//             ),
//             const Divider(
//               height: 0,
//               color: Colors.white,
//               thickness: 2,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     focusNode: itemNode,
//                     onSubmitted: (value) =>
//                         addItem(listProvider, selectedListId),
//                     controller: itemController,
//                     cursorColor: Colors.white54,
//                     style: const TextStyle(color: Colors.white),
//                     textCapitalization: TextCapitalization.sentences,
//                     decoration: const InputDecoration(
//                         focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.white,
//                             width: 2,
//                           ),
//                         ),
//                         enabledBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.white,
//                             width: 1,
//                           ),
//                         ),
//                         contentPadding: EdgeInsets.only(left: 8),
//                         hintText: 'Enter item',
//                         hintStyle: TextStyle(
//                           color: Colors.white38,
//                         )),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () => addItem(listProvider, selectedListId),
//                   icon: const Icon(
//                     Icons.add,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 3,
//             ),
//             listProvider.selectedListId == null
//                 ? Expanded(
//                     child: Center(
//                       child: TextButton(
//                         child: const Text(
//                           'Select a list or add a new one',
//                           style: TextStyle(color: Colors.white60),
//                         ),
//                         onPressed: () {
//                           addNewList(listProvider);
//                         },
//                       ),
//                     ),
//                   )
//                 : MyListView(
//                     listId: selectedListId!,
//                   ),
//             const Divider(
//               height: 0,
//               color: Colors.white,
//               thickness: 2,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Icons.select_all),
//                   color: Colors.white60,
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Icons.check_box_outline_blank),
//                   color: Colors.white60,
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Icons.delete_sweep),
//                   color: Colors.white60,
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Icons.drive_file_move),
//                   color: Colors.white60,
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Icons.share),
//                   color: Colors.white60,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   PopupMenuItem<String> _buildMenuItem(
//       String text, IconData icon, VoidCallback onTap) {
//     return PopupMenuItem<String>(
//       onTap: onTap,
//       child: Row(
//         children: [
//           Icon(icon),
//           const SizedBox(width: 6),
//           Text(text),
//         ],
//       ),
//     );
//   }

//   void addNewList(ListProvider listProvider) {
//     TextEditingController nameController = TextEditingController();
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               backgroundColor: Colors.black,
//               shape: ContinuousRectangleBorder(
//                 borderRadius: BorderRadius.circular(25),
//                 side: const BorderSide(width: 2, color: Colors.white),
//               ),
//               title: const Text(
//                 'Add New List',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.white),
//               ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     maxLines: 1,
//                     maxLength: 24,
//                     style: const TextStyle(color: Colors.white),
//                     controller: nameController,
//                     decoration: const InputDecoration(
//                       hintText: 'List Name',
//                       hintStyle: TextStyle(color: Colors.white54),
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white60),
//                       ),
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white60, width: 2),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       nameController.text.isEmpty
//                           ? null
//                           : setState(() {
//                               ListModel list = ListModel(
//                                 id: const Uuid().v4(),
//                                 createdBy:
//                                     FirebaseAuth.instance.currentUser!.uid,
//                                 shareWith: [],
//                                 dateCreated: Timestamp.now().toString(),
//                                 name: nameController.text,
//                                 items: [],
//                               );
//                               //    firestoreService.createList(list);
//                               listProvider.addList(list);

//                               Navigator.pop(context);
//                               listProvider.selectList(list.id);
//                             });
//                     },
//                     child: const Text(
//                       'Add',
//                       style: TextStyle(color: Colors.white),
//                     ))
//               ],
//             ));
//   }

//   // void _showMoveListDialog() async {
//   //   try {
//   //     final String result = await showDialog(
//   //       context: context,
//   //       builder: (context) => MoveListDialog(
//   //         selectedListID: currentList.id,
//   //         ref: ref,
//   //       ),
//   //     );

//   //     String moveToList = result;
//   //     selectList(moveToList);
//   //   } catch (e) {
//   //     // Do nothing
//   //   }
//   // }

//   void showErrorDialog(BuildContext context, String title, String content) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.black,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(25),
//             side: const BorderSide(color: Colors.white60, width: 2),
//           ),
//           title: Text(
//             title,
//             style: const TextStyle(color: Colors.white),
//           ),
//           content: Text(content, style: const TextStyle(color: Colors.white70)),
//           actionsAlignment: MainAxisAlignment.spaceBetween,
//           actions: <Widget>[
//             MyButton(
//                 text: 'Add list',
//                 icon: Icons.add,
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   //  addNewList();
//                 }),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Ok'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../const.dart';
import '../../../models/item_model.dart';
import '../../../models/list_model.dart';
import '../../../providers/list_provider.dart';
import 'list_view.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late FocusNode _itemNode;
  late TextEditingController _itemController;

  @override
  void initState() {
    super.initState();
    _itemNode = FocusNode();
    _itemController = TextEditingController();

    _itemNode.addListener(() {
      if (!_itemNode.hasFocus) {
        _itemController.clear();
      }
    });
  }

  @override
  void dispose() {
    _itemNode.dispose();
    _itemController.dispose();
    super.dispose();
  }

  void _addItem(ListProvider listProvider, String? listId) {
    if (_itemController.text.trim().isEmpty) {
      _itemController.clear();
      return;
    }
    listProvider.addItemToList(
      listId ?? '',
      ItemModel(name: _itemController.text, isDone: false, details: ''),
    );
    _itemNode.requestFocus();
    _itemController.clear();
  }

  void selectListFromList(ListModel list) {
    setState(() {
      selectedList = list;
    });
  }

  ListModel? selectedList;
  @override
  Widget build(BuildContext context) {
    return Consumer<ListProvider>(
      builder: (context, listProvider, child) {
        listProvider.fetchLists();
        final lists = listProvider.lists;
        if (lists.isEmpty) {
          return Center(
            child: myButton1(
              'Add a new list',
              () => _addNewList(listProvider),
            ),
          );
        }

        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Column(
            children: <Widget>[
              _buildListSelectorAndMenu(
                  listProvider, (value) => selectListFromList(value!)),
              const Divider(height: 0, color: Colors.white, thickness: 2),
              _buildItemInput(listProvider, selectedList?.id),
              _buildListViewOrPlaceholder(listProvider, selectedList),
              const Divider(height: 0, color: Colors.white, thickness: 2),
              _buildActionIcons(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListSelectorAndMenu(
      ListProvider listProvider, void Function(ListModel?) onChanged) {
    selectedList = listProvider.selectedList;

    return Row(
      children: [
        Expanded(
          child: DropdownButton<ListModel>(
            value: selectedList,
            onChanged: onChanged,
            items: [
              DropdownMenuItem<ListModel>(
                value: null,
                child: TextButton.icon(
                  label: const Text('Add new list',
                      style: TextStyle(color: Colors.white60)),
                  icon: const Icon(Icons.add_box, color: Colors.white60),
                  onPressed: () => _addNewList(listProvider),
                ),
              ),
              ...listProvider.lists.map((list) => DropdownMenuItem<ListModel>(
                    value: list,
                    child: Text(list.name),
                  )),
            ],
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            style: const TextStyle(color: Colors.white),
            dropdownColor: const Color.fromARGB(255, 48, 48, 48),
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (value) => _handleMenuSelection(value, listProvider),
          itemBuilder: (BuildContext context) => [
            _buildPopupMenuItem('Add new list', Icons.add_box, 'add'),
            // Add other menu items here similarly
          ],
        ),
      ],
    );
  }

  Widget _buildItemInput(ListProvider listProvider, String? listId) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            focusNode: _itemNode,
            controller: _itemController,
            onSubmitted: (_) => _addItem(listProvider, listId),
            cursorColor: Colors.white54,
            style: const TextStyle(color: Colors.white),
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              contentPadding: EdgeInsets.only(left: 8),
              hintText: 'Enter item',
              hintStyle: TextStyle(color: Colors.white38),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: () => _addItem(listProvider, listId),
        ),
      ],
    );
  }

  Widget _buildListViewOrPlaceholder(
      ListProvider listProvider, ListModel? list) {
    return Expanded(
      child: list == null
          ? Center(
              child: TextButton(
                child: const Text('Select a list or add a new one',
                    style: TextStyle(color: Colors.white60)),
                onPressed: () => _addNewList(listProvider),
              ),
            )
          : MyListView(list: list),
    );
  }

  Widget _buildActionIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _actionIcon(Icons.select_all, () {}),
        _actionIcon(Icons.check_box_outline_blank, () {}),
        _actionIcon(Icons.delete_sweep, () {}),
        _actionIcon(Icons.drive_file_move, () {}),
        _actionIcon(Icons.share, () {}),
      ],
    );
  }

  Widget _actionIcon(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: Colors.white60),
      onPressed: onPressed,
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
      String text, IconData icon, String value) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  void _handleMenuSelection(String value, ListProvider listProvider) {
    switch (value) {
      case 'add':
        _addNewList(listProvider);
        break;
      // Handle other cases similarly
    }
  }

  void _addNewList(ListProvider listProvider) {
    TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,

        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          side: BorderSide(width: 2, color: Colors.white),
        ),

        // ... [Dialog setup remains similar, but ensure to use Theme for consistency]
        title: const Text('Add New List',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: 'List Name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                ListModel newList = ListModel(
                  id: const Uuid().v4(),
                  createdBy: FirebaseAuth.instance.currentUser!.uid,
                  name: nameController.text,
                  items: [],
                );
                listProvider.addList(newList);
                listProvider.selectList(newList);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
