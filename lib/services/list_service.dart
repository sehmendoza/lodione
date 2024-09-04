import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lodione/models/list_model.dart';

class ListService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

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
        .add(list.toFirestore());
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
}
