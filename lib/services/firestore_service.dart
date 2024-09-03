import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/item_model.dart';
import '../models/list_model.dart';

class FirestoreService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _listsCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('lists');

  Future<void> createList(ListModel list) async {
    _listsCollection.doc(list.id).set(list.toFirestore());
  }

  Future<void> updateList(ListModel list) async {
    await _listsCollection.doc(list.id).update(list.toFirestore());
  }

  Future<void> deleteList(String id) async {
    await _listsCollection.doc(id).delete();
  }

  Future<void> addItemToList(String listId, ItemModel item) async {
    await _listsCollection.doc(listId).update({
      'items': FieldValue.arrayUnion([item.toFirestore()])
    });
  }
}
