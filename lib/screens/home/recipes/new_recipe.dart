import 'package:flutter/material.dart';

import '../../../models/list_model.dart';

class NewRecipe extends StatefulWidget {
  const NewRecipe({super.key});

  @override
  State<NewRecipe> createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  List<ListItem> ingredients = [];
  TextEditingController itemController = TextEditingController();
  TextEditingController directionController = TextEditingController();
  final FocusNode _ingFocus = FocusNode();

  void addIngredient() {
    setState(() {
      ingredients
          .add(ListItem(id: '23', name: itemController.text, isDone: false));
      itemController.clear();
      _ingFocus.requestFocus();
    });
  }

  List<String> steps = [];

  void _reorderSteps(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final String item = steps.removeAt(oldIndex);
      steps.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text(
          'New Recipe',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 250,
                  child: TextField(
                    focusNode: _focusNode,
                    textCapitalization: TextCapitalization.words,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontSize: 21,
                    ),
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 2,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white60,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Recipe Name',
                    style: TextStyle(
                      color: _isFocused ? Colors.white : Colors.white54,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Row(
                children: [
                  Text(
                    'Ingredients:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ingredients.length,
                    itemBuilder: (context, index) {
                      var ingredient =
                          ingredients.map((item) => item.name).toList();
                      return Row(
                        children: [
                          const Text(
                            '\u2022   ',
                            style: TextStyle(
                              height: 2,
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ingredient[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 14),
                child: Row(
                  children: [
                    const Text(
                      '\u2022',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _ingFocus,
                        onSubmitted: (value) {
                          addIngredient();
                        },
                        controller: itemController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white38),
                            hintText: 'Enter Ingredient',
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                addIngredient();
                              },
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  Text(
                    'Direction:',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                proxyDecorator: (child, index, animation) =>
                    _buildFeedback(context, index),
                onReorder: _reorderSteps,
                children: <Widget>[
                  for (final step in steps)
                    ListTile(
                      key: ValueKey(step),
                      leading: Text(
                        '${steps.indexOf(step) + 1}.',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 21),
                      ),
                      title: Text(
                        step,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: const Icon(
                        Icons.drag_handle,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 10),
                    child: Text(
                      '${steps.length + 1}.',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: directionController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 12),
                        hintStyle: const TextStyle(
                          color: Colors.white38,
                        ),
                        hintText: 'Enter next step',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              steps.add(directionController.text);
                              directionController.clear();
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text("Save Recipe"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedback(BuildContext context, int index) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Text(
            '${index + 1}.',
            style: const TextStyle(color: Colors.black, fontSize: 21),
          ),
          title: Text(
            steps[index],
            style: const TextStyle(color: Colors.black),
          ),
          trailing: const Icon(Icons.drag_handle, color: Colors.black),
        ),
      ),
    );
  }
}
