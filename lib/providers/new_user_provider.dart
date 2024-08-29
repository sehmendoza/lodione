import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

final allUserProvider = ChangeNotifierProvider<AllUserProvider>((ref) {
  return AllUserProvider();
});

class AllUserProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _userStream;

  AllUserProvider() {
    _userStream = _firestore.collection('users').snapshots();
    _userStream.listen((snapshot) {
      _users = snapshot.docs
          .map((doc) {
            if (doc.data() is Map<String, dynamic>) {
              return UserModel.fromFirestore(
                  doc.data() as Map<String, dynamic>);
            } else {
              return null;
            }
          })
          .where((user) => user != null) // Filter out null values
          .cast<UserModel>() // Cast List<UserModel?> to List<UserModel>
          .toList();
      notifyListeners();
    });
  }

  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  Future<void> addUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toFirestore());
    _users.add(user);
    notifyListeners();
  }
}
