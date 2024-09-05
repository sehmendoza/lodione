import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lodione/const.dart';
import 'package:lodione/test/task_model.dart';
import 'task_service.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final TaskService _taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: white),
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      'Grocery List',
                      style: TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal),
                    ),
                    subtitle: const Text('by: John Doe'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  const Text('0/5 completed'),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add List'),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Select a list',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const Card(
                    child: ListTile(
                      title: Text('Grocery List'),
                      subtitle: Text('by: John Doe'),
                      trailing: Text('0/5 completed'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('To-Do List'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Task>>(
              stream: _taskService.getTasks(),
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
                            _taskService.updateTask(task);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTaskDialog(context),
        child: const Icon(Icons.add),
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
                _taskService.addTask(Task(
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
