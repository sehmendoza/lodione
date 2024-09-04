import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lodione/models/item_model.dart';
import 'package:lodione/models/list_model.dart';
import 'package:lodione/providers/user_provider.dart';

class ListService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  FirebaseAuth get auth => _firebaseAuth;

  UserProvider get userProvider => UserProvider();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<List<ListModel>> fetchList() async {
    List<ListModel> lists = [];

    QuerySnapshot? querySnapshot = await _db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('lists')
        .get();

    for (var doc in querySnapshot.docs) {
      var list = ListModel.fromFirestore(doc.data() as Map<String, dynamic>);
      lists.add(list);
    }

    return lists;
  }

  Stream<List<ListModel>> streamLists() {
    return _db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('lists')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ListModel.fromFirestore(doc.data());
      }).toList();
    });
  }

  void addList(ListModel list) {
    _db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('lists')
        .doc(list.id)
        .set(list.toFirestore());
  }

  void removeList(ListModel list) {
    _db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('lists')
        .doc(list.id)
        .delete();
  }

  void updateList(ListModel list) {
    _db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('lists')
        .doc(list.id)
        .update(list.toFirestore());
  }

  void addItemToList(String listId, ItemModel item) {
    _db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('lists')
        .doc(listId)
        .update({
      'items': FieldValue.arrayUnion([item.toFirestore()])
    });
  }

  void removeItemFromList(String listId, String itemId) {
    _db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('lists')
        .doc(listId)
        .update({
      'items': FieldValue.arrayRemove([itemId])
    });
  }

  void updateItemInList(String listId, ItemModel item) {
    _db
        .collection('users')
        .doc(currentUser!.uid)
        .collection('lists')
        .doc(listId)
        .update({
      'items': FieldValue.arrayUnion([item.toFirestore()])
    });
  }
}
