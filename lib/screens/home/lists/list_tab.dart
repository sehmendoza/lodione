import 'package:flutter/material.dart';

import '../../../models/list_model.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  List<ListModel> lists = [
    ListModel(
      id: '1',
      name: 'Mendoza',
      items: [
        ListItem(id: '2', name: 'Banana', isDone: false),
        ListItem(id: '3', name: 'Saging', isDone: false),
        ListItem(id: '4', name: 'Apple', isDone: false),
        ListItem(id: '5', name: 'Root Beer', isDone: false),
      ],
    ),
    ListModel(
      id: '2',
      name: 'Policarpio',
      items: [
        ListItem(id: '2', name: 'Chens', isDone: false),
        ListItem(id: '3', name: 'Saging', isDone: false),
        ListItem(id: '4', name: 'Beer', isDone: false),
        ListItem(id: '5', name: 'Root Beer', isDone: false),
      ],
    ),
  ];

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
                        lists.add(ListModel(
                            id: '2',
                            name: nameController.text,
                            items: [
                              ListItem(id: '4', name: 'Beer', isDone: false),
                            ]));
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

  late String dropdownValue;
  late ListModel selectedList;
  @override
  void initState() {
    super.initState();
    dropdownValue = lists[0].id;
    selectedList = lists[0];
  }

  void selectList(id) {
    setState(() {
      selectedList = lists.firstWhere((list) => list.id == id);
    });
  }

  void addItem({required String listID, required ListItem item}) {
    setState(() {
      lists.firstWhere((list) => list.id == listID).items.insert(0, item);
    });
  }

  TextEditingController itemController = TextEditingController();
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
              children: [
                const Text(
                  'List: ',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 5,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  iconSize: 18,
                  //elevation: 16,
                  //    style: const TextStyle(color: Colors.white24),
                  underline: Container(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(2),
                  dropdownColor: const Color.fromARGB(255, 52, 52, 52),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: lists
                      .map<DropdownMenuItem<String>>((ListModel listModel) {
                    return DropdownMenuItem<String>(
                      onTap: () => selectList(listModel.id),
                      value: listModel.id,
                      child: Text(
                        listModel.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
                TextButton(
                    onPressed: () {
//addNewList
                    },
                    child: const Text(
                      'Add list',
                      style: TextStyle(
                          color: Colors.white70, fontStyle: FontStyle.italic),
                    ))
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
                    addItem(
                      listID: dropdownValue,
                      item: ListItem(
                        id: '4',
                        name: itemController.text,
                        isDone: false,
                      ),
                    );
                    itemController.clear();
                  },
                  icon: const Icon(
                    Icons.arrow_circle_down,
                    color: Colors.white70,
                    size: 28,
                  ))
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: selectedList.items.length,
                itemBuilder: (context, index) {
                  var items = selectedList.items[index];
                  return ListTile(
                    leading: Checkbox(
                        value: items.isDone,
                        onChanged: (value) {
                          setState(() {
                            items.isDone = !items.isDone;
                          });
                        }),
                    title: Text(
                      items.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: items.subtitle == null
                        ? null
                        : Text(
                            items.subtitle!,
                            style: const TextStyle(color: Colors.white),
                          ),
                    trailing: PopupMenuButton(
                      itemBuilder: (_) => [
                        const PopupMenuItem(
                          value: 'option1',
                          child: Text('Edit item'),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              selectedList.items[index].subtitle == 'Sub';
                            });
                          },
                          value: 'option2',
                          child: const Text('Add detail'),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setState(() {
                              selectedList.items
                                  .removeWhere((item) => item.id == items.id);
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
                  );
                }),
          )
        ],
      ),
    );
  }
}
