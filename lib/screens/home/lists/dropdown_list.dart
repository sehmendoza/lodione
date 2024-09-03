import 'package:flutter/material.dart';

import '../../../models/list_model.dart';

DropdownMenuItem<ListModel> dropIt(listModel) {
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
}
