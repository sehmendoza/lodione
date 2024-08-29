import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<UserModel?> getCurrentUserStream() {
    return FirebaseAuth.instance.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      final doc = await _firestore.collection('users').doc(user.uid).get();
      return doc.exists ? UserModel.fromFirestore(doc.data()!) : null;
    });
  }

  Future<void> updateUser(UserModel user) {
    return _firestore
        .collection('users')
        .doc(user.id)
        .update(user.toFirestore());
  }
}
