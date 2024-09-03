import 'package:flutter/material.dart';

import '../../../models/list_model.dart';

class DropdownList extends StatefulWidget {
  const DropdownList(
      {super.key, required this.currentValue, required this.lists});

  final String currentValue;
  final List<ListModel> lists;
  @override
  State<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: false,
      value: _selectedValue,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      iconSize: 18,
      // underline: Container(
      //     height: 1, color: null), // Fixed underline styling
      borderRadius: BorderRadius.circular(2),
      dropdownColor: const Color.fromARGB(255, 30, 30, 30),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedValue = newValue;
          }); // Call the onChanged callback
        }
      },
      underline: const SizedBox(),
      items: widget.lists.map<DropdownMenuItem<String>>((ListModel listModel) {
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
              listModel.items.isEmpty
                  ? const SizedBox()
                  : Container(
                      margin: const EdgeInsets.only(left: 6),
                      padding: const EdgeInsets.all(7.5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Text(
                        listModel.items.length.toString(),
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
    );
  }
}
