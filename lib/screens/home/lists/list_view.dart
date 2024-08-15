import 'package:flutter/material.dart';

import '../../../models/list_model.dart';

class MyListView extends StatefulWidget {
  const MyListView({super.key, required this.selectedList});

  final ListModel selectedList;

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: widget.selectedList.items.length,
          itemBuilder: (context, index) {
            var items = widget.selectedList.items[index];
            return Dismissible(
              background: Container(
                color: Colors.white38,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete),
              ),
              onDismissed: (direction) {
                setState(() {
                  widget.selectedList.items
                      .removeWhere((item) => item.id == items.id);
                });
              },
              key: ValueKey(items.id),
              child: ListTile(
                key: ValueKey(items.id),
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
                          widget.selectedList.items[index].subtitle == 'Sub';
                        });
                      },
                      value: 'option2',
                      child: const Text('Add detail'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          widget.selectedList.items
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
              ),
            );
          }),
    );
  }
}
