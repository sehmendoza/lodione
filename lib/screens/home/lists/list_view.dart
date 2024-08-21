import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/list_provider.dart';

class MyListView extends ConsumerStatefulWidget {
  const MyListView({super.key, required this.listID});

  final String listID;

  @override
  ConsumerState<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends ConsumerState<MyListView> {
  @override
  Widget build(BuildContext context) {
    final items = ref
        .watch(listProvider)
        .firstWhere((list) => list.id == widget.listID)
        .items;
    final selectedList =
        ref.watch(listProvider).firstWhere((list) => list.id == widget.listID);
    return Expanded(
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];
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
                      .removeItemFromList(selectedList.id, item.id);
                });
              },
              key: ValueKey(item.id),
              child: ListTile(
                key: ValueKey(item.id),
                leading: Checkbox(
                    value: item.isDone,
                    onChanged: (value) {
                      setState(() {
                        item.isDone = !item.isDone;
                      });
                    }),
                title: Text(
                  item.name,
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
                              .removeItemFromList(selectedList.id, item.id);
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
