import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/list_model.dart';
import '../../../providers/list_provider.dart';

class MoveListDialog extends StatefulWidget {
  const MoveListDialog(
      {super.key, required this.selectedListID, required this.ref});

  final String selectedListID;
  final dynamic ref;

  @override
  State<MoveListDialog> createState() => _MoveListDialogState();
}

class _MoveListDialogState extends State<MoveListDialog> {
  String newListDropdownValue = '';
  @override
  void initState() {
    newListDropdownValue = widget.selectedListID;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ref = widget.ref;
// var provider = Provider.of<ListProvider>(context, listen: false);
    // var mgaLists = ref.watch(listProvider);
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
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [],
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (newListDropdownValue == widget.selectedListID) {
                Navigator.pop(context);
                return;
              }
              // ref.read(listProvider.notifier).moveItemsToOtherList(
              //     widget.selectedListID, newListDropdownValue);

              Navigator.pop(context, newListDropdownValue);
            },
            child: const Text(
              'Move',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
