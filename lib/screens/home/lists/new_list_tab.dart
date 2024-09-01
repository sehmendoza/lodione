import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lodione/models/list_model.dart';

import '../../../models/item_model.dart';

class NewListTab extends ConsumerWidget {
  const NewListTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listModel = ref.watch(listModelProvider);

    return Column(
      children: [
        Center(
          child: Text('Items: ${listModel.items.length}'),
        ),
        listModel.items.toList().isEmpty
            ? const Text('No items in the list')
            : Expanded(
                child: ListView.builder(
                  itemCount: listModel.items.length,
                  itemBuilder: (context, index) {
                    final item = listModel.items[index];
                    return Dismissible(
                      key: ValueKey(item),
                      onDismissed: (direction) {
                        ref.read(listModelProvider.notifier).removeItem(item);
                      },
                      child: ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.details),
                      ),
                    );
                  },
                ),
              ),
        FloatingActionButton(
          onPressed: () {
            ref.read(listModelProvider.notifier).addItem(
                  ItemModel(name: 'New Item', details: 'Details'),
                ); // Add a new item
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class ListModelNotifier extends StateNotifier<ListModel> {
  ListModelNotifier() : super(ListModel(name: 'Default List'));

  void updateListName(String newName) {
    state = state.copyWith(name: newName);
  }

  void addItem(ItemModel item) {
    state = state.copyWith(
      items: [...state.items, item],
    );
  }

  void removeItem(ItemModel item) {
    state = state.copyWith(
      items: state.items.where((i) => i != item).toList(),
    );
  }

  // Add more methods as needed for your state management
}

final listModelProvider = StateNotifierProvider<ListModelNotifier, ListModel>(
  (ref) => ListModelNotifier(),
);
