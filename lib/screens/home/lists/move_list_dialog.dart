import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/list_provider.dart';

class MoveListDialog extends ConsumerStatefulWidget {
  const MoveListDialog(
      {super.key, required this.selectedListID, required this.ref});

  final String selectedListID;
  final dynamic ref;

  @override
  ConsumerState<MoveListDialog> createState() => _MoveListDialogState();
}

class _MoveListDialogState extends ConsumerState<MoveListDialog> {
  String newListDropdownValue = '';
  @override
  void initState() {
    newListDropdownValue = widget.selectedListID;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ref = widget.ref;

    var mgaLists = ref.watch(listProvider);
    return AlertDialog(
      backgroundColor: Colors.black,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: const BorderSide(width: 2, color: Colors.white),
      ),
      title: const Text(
        'Move items to other list',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            value: newListDropdownValue,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            iconSize: 18,
            underline:
                Container(height: 1, color: null), // Fixed underline styling
            borderRadius: BorderRadius.circular(2),
            dropdownColor: const Color.fromARGB(255, 30, 30, 30),
            onChanged: (newValue) {
              setState(() {
                newListDropdownValue = newValue!;
              });
            },
            items:
                mgaLists.map<DropdownMenuItem<String>>((ListModel listModel) {
              return DropdownMenuItem<String>(
                value: listModel.id,
                child: Row(
                  children: [
                    Text(
                      listModel.name,
                      style: const TextStyle(color: Colors.white),
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
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              ref.read(listProvider.notifier).moveItemsToOtherList(
                  widget.selectedListID,
                  widget.selectedListID,
                  newListDropdownValue);
              Navigator.pop(context);
            },
            child: const Text(
              'Move',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
