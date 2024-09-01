import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lodione/providers/list_provider.dart';
import 'package:lodione/services/firestore_service.dart';
import 'package:lodione/widgets/buttons.dart';
import '../../../models/item_model.dart';
import '../../../models/list_model.dart';
import '../../../widgets/dialogs.dart';
import 'list_view.dart';
import 'move_list_dialog.dart';

final FirestoreService firestoreService = FirestoreService();

class ListTab extends ConsumerStatefulWidget {
  const ListTab({super.key});

  @override
  ConsumerState<ListTab> createState() => _ListTabState();
}

class _ListTabState extends ConsumerState<ListTab> {
  @override
  void initState() {
    super.initState();
    _fetchAndSetModels();
  }

  List<ListModel> _list = [];
  ListModel _currentList = ListModel(name: 'My List', items: []);

  Future<void> _fetchAndSetModels() async {
    List<ListModel> list = await firestoreService.fetchModels();
    if (list.isNotEmpty) {
      setState(() {
        _list = list;
        _currentList = list[0];
      });
    }
  }

  void selectList(id) {
    var newList = _list.firstWhere((list) => list.id == id);

    setState(() {
      _currentList = newList;
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
        ? showErrorDialog(context, 'Cannot add more items',
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
    return Container(
      width: double.infinity,
      height: double.infinity,
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
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //  crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<ListModel>(
                  isExpanded: false,
                  value: _currentList,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  iconSize: 18,
                  // underline: Container(
                  //     height: 1, color: null), // Fixed underline styling
                  borderRadius: BorderRadius.circular(2),
                  dropdownColor: const Color.fromARGB(255, 30, 30, 30),
                  onChanged: (ListModel? newValue) {
                    setState(() {
                      _currentList = newValue!; // Directly call selectList here
                    });
                  },
                  underline: const SizedBox(),
                  items: _list
                      .map<DropdownMenuItem<ListModel>>((ListModel listModel) {
                    return DropdownMenuItem<ListModel>(
                      value: listModel,
                      child: Row(
                        children: [
                          Text(
                            listModel.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 6),
                            padding: const EdgeInsets.all(7.5),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Text(
                              '0',
                              //  "ref
                              //       .watch(listProvider)
                              //       .firstWhere((list) => list.id == listModel.id)
                              //       .items
                              //       .length
                              //       .toString()",

                              style: TextStyle(
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

                // Popup Menu
                const Spacer(),
                PopupMenuButton<String>(
                  onOpened: () {
                    itemNode.unfocus();
                  },
                  icon: const Icon(Icons.more_vert, color: Colors.white70),
                  itemBuilder: (BuildContext context) => [
                    _buildMenuItem('Add new list', Icons.add_box, addNewList),
                    _buildMenuItem('Select all items', Icons.select_all, () {
                      ref
                          .read(listProvider.notifier)
                          .selectAll(_currentList.id);
                    }),
                    _buildMenuItem(
                        'Delete all checked items', Icons.delete_sweep, () {
                      ref
                          .read(listProvider.notifier)
                          .removeCompleted(_currentList.id);
                    }),
                    _buildMenuItem(
                        'Unselect all items', Icons.check_box_outline_blank,
                        () {
                      ref
                          .read(listProvider.notifier)
                          .unselectAll(_currentList.id);
                    }),
                    _buildMenuItem('Move marked items to other list',
                        Icons.drive_file_move, () {
                      _showMoveListDialog();
                    }),
                    _buildMenuItem('Share list', Icons.share, () {
                      showMyErrorDialog(context, 'Share list',
                          'This feature is not yet available.');
                    }),
                    _buildMenuItem('Clear all items', Icons.delete_forever, () {
                      ref
                          .read(listProvider.notifier)
                          .clearList(_currentList.id);
                    }),
                    _buildMenuItem('Delete list', Icons.close, () {
                      _currentList.name == 'My List'
                          ? showMyErrorDialog(
                              context,
                              'Cannot delete "My List"',
                              "It's for your personal use only.")
                          : setState(() {
                              ref
                                  .read(listProvider.notifier)
                                  .removeList(_currentList.id);
                              _currentList = ref.read(listProvider).first;
                            });
                    }),
                  ],
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
                      listID: _currentList.id,
                      item: ItemModel(
                          name: itemController.text,
                          isDone: false,
                          details: ''),
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
                    itemController.clear();
                    return;
                  }
                  addItem(
                    listID: _currentList.id,
                    item: ItemModel(
                        name: itemController.text, isDone: false, details: ''),
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
            list: _currentList,
          ),
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
                              ListModel list = ListModel(
                                  name: nameController.text, items: []);

                              ref.read(listProvider.notifier).addList(list);

                              _currentList = list;
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

  void _showMoveListDialog() async {
    try {
      final String result = await showDialog(
        context: context,
        builder: (context) => MoveListDialog(
          selectedListID: _currentList.id,
          ref: ref,
        ),
      );

      String moveToList = result;
      selectList(moveToList);
    } catch (e) {
      // Do nothing
    }
  }

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
                  addNewList();
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
