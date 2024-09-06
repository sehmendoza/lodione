import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'task_model.dart';

class ListService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Task>> getLists() {
    String? userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception("User not logged in");

    return _firestore.collection('lists').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Task.fromFirestore(doc))
          .where((task) => task.ownerId == userId)

          // task.sharedWith.contains(userId))
          .toList();
    });
  }

  Future<void> addTask(Task task) async {
    await _firestore.collection('lists').add(task.toFirestore());
  }

  Future<void> updateTask(Task task) async {
    await _firestore
        .collection('lists')
        .doc(task.id)
        .update(task.toFirestore());
  }

  // Check if the user is an admin - this would be more complex in a real scenario
  // Future _isAdmin(String userId) {
  //   // For simplicity, let's assume there's a field 'isAdmin' in the user document
  //   return _firestore
  //       .collection('users')
  //       .doc(userId)
  //       .get()
  //       .then((doc) => doc.exists ? (doc.data()?['isAdmin'] ?? false) : false);
  // }
}
