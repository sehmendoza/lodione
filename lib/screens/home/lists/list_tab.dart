import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lodione/providers/list_provider.dart';
import 'package:lodione/widgets/buttons.dart';
import '../../../models/list_model.dart';
import '../../../widgets/dialogs.dart';
import 'list_view.dart';
import 'move_list_dialog.dart';

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
    final mgaLists = ref.watch(listProvider);
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //  crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  isExpanded: false,
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  iconSize: 18,
                  // underline: Container(
                  //     height: 1, color: null), // Fixed underline styling
                  borderRadius: BorderRadius.circular(2),
                  dropdownColor: const Color.fromARGB(255, 30, 30, 30),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      selectList(
                          dropdownValue); // Directly call selectList here
                    });
                  },
                  underline: const SizedBox(),
                  items: mgaLists
                      .map<DropdownMenuItem<String>>((ListModel listModel) {
                    return DropdownMenuItem<String>(
                      value: listModel.id,
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
                            child: Text(
                              ref
                                  .watch(listProvider)
                                  .firstWhere((list) => list.id == listModel.id)
                                  .items
                                  .length
                                  .toString(),
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

                // Popup Menu
                const Spacer(),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.white70),
                  itemBuilder: (BuildContext context) => [
                    _buildMenuItem('Add new list', Icons.add_box, addNewList),
                    _buildMenuItem('Select all items', Icons.select_all, () {
                      ref
                          .read(listProvider.notifier)
                          .selectAll(selectedList.id);
                    }),
                    _buildMenuItem(
                        'Delete all checked items', Icons.delete_sweep, () {
                      ref
                          .read(listProvider.notifier)
                          .removeCompleted(selectedList.id);
                    }),
                    _buildMenuItem(
                        'Unselect all items', Icons.check_box_outline_blank,
                        () {
                      ref
                          .read(listProvider.notifier)
                          .unselectAll(selectedList.id);
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
                          .clearList(selectedList.id);
                    }),
                    _buildMenuItem('Delete list', Icons.close, () {
                      selectedList.name == 'My List'
                          ? showMyErrorDialog(
                              context,
                              'Cannot delete "My List"',
                              "It's for your personal use only.")
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
                    listID: dropdownValue,
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
            listID: selectedList.id,
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

  void _showMoveListDialog() async {
    try {
      final String result = await showDialog(
        context: context,
        builder: (context) => MoveListDialog(
          selectedListID: selectedList.id,
          ref: ref,
        ),
      );

      dropdownValue = result;

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
