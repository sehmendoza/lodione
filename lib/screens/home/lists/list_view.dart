import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/list_model.dart';
import '../../../providers/list_provider.dart';

class MyListView extends ConsumerStatefulWidget {
  const MyListView({super.key, required this.selectedList});

  final ListModel selectedList;

  @override
  ConsumerState<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends ConsumerState<MyListView> {
  @override
  Widget build(BuildContext context) {
    final selectedList = widget.selectedList;
    return Expanded(
      child: ListView.builder(
          itemCount: selectedList.items.length,
          itemBuilder: (context, index) {
            var items = selectedList.items[index];
            return Dismissible(
              background: Container(
                color: Colors.white38,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete),
              ),
              onDismissed: (direction) {
                setState(() {
                  ref
                      .read(listProvider.notifier)
                      .removeItemFromList(selectedList.id, items.id);
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
                // subtitle: items.subtitle == null
                //     ? null
                //     : Text(
                //         items.subtitle!,
                //         style: const TextStyle(color: Colors.white),
                //       ),
                trailing: PopupMenuButton(
                  itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: 'option1',
                      child: Text('Edit item'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        // setState(() {
                        //   widget.selectedList.items[index].subtitle == 'Sub';
                        // });
                      },
                      value: 'option2',
                      child: const Text('Add detail'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        setState(() {
                          ref
                              .read(listProvider.notifier)
                              .removeItemFromList(selectedList.id, items.id);
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
