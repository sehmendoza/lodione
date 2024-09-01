import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/item_model.dart';
import '../models/list_model.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final userID = FirebaseAuth.instance.currentUser!.uid;

  Future<List<ListModel>> fetchModels() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('lists')
          .get();
      return snapshot.docs.map((doc) {
        return ListModel(
          name: doc['name'],
          items: (doc['items'] as List)
              .map(
                (item) => ItemModel(
                  name: item['name'],
                  details: item['details'],
                  isDone: item['isDone'],
                ),
              )
              .toList(),
        );
      }).toList();
    } catch (e) {
      print("Failed to fetch models: $e");
      return [];
    }
  }
}
