import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lodione/const.dart';
import 'package:lodione/test/drawer.dart';
import 'package:lodione/test/task_model.dart';
import 'task_service.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final ListService _listService = ListService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 3.0, left: 3.0, right: 3.0, bottom: 5),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addTaskDialog(context),
          child: const Icon(Icons.add),
        ),
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: const Text(
            'To-Do List',
          ),
          centerTitle: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Task>>(
                stream: _listService.getLists(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No tasks. Add some!'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Task task = snapshot.data![index];
                      return ListTile(
                        title: Text(
                          task.title,
                          style: const TextStyle(
                              color: white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins',
                              fontStyle: FontStyle.normal),
                        ),
                        subtitle: Text(task.description),
                        trailing: Checkbox(
                          value: task.isCompleted,
                          onChanged: (bool? value) {
                            setState(() {
                              task.isCompleted = value!;
                              _listService.updateTask(task);
                            });
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addTaskDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Task Title"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                _listService.addTask(Task(
                  id: '', // Firestore will generate an ID
                  title: titleController.text,
                  ownerId: FirebaseAuth.instance.currentUser!.uid,
                ));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
