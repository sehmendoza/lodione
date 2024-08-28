import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final userDataProvider =
    StateNotifierProvider<UserDataNotifier, Map<String, dynamic>>((ref) {
  return UserDataNotifier();
});

class UserDataNotifier extends StateNotifier<Map<String, dynamic>> {
  UserDataNotifier() : super({}) {
    _initUserData();
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  String get currentUsername => state['username'] ?? 'Username';
  String get currentName => state['name'] ?? 'Name';

  void _initUserData() {
    if (_user != null) {
      _firestore
          .collection('users')
          .doc(_user.uid)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          state = snapshot.data()!;
        }
      });
    }
  }

  void updateUserData(Map<String, dynamic> newData) {
    if (_user != null) {
      _firestore.collection('users').doc(_user.uid).update(newData);
      state = {
        ...state,
        ...newData
      }; // Update local state immediately for better UX
    }
  }
}
