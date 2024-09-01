import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class UserProvider extends StateNotifier<UserModel?> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserProvider() : super(null) {
    _initializeUser();
  }
  String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _initializeUser() async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        state = UserModel.fromJson(userDoc.data()!);
      } else {
        state = null;
      }
    } catch (e) {
      state = null;
    }
  }

  Future<void> updateUser(UserModel updatedUser) async {
    if (state == null) return;

    try {
      await _firestore
          .collection('users')
          .doc(state!.id)
          .set(updatedUser.toFirestore());
      state = updatedUser;
    } catch (e) {
      state = state;
    }
  }

  void togglePrivacy(value) {
    if (state == null) return;
    state = state!.copyWith(isPrivate: value);
    _updateUser();
  }

  Future<void> _updateUser() async {
    if (state == null) return;

    try {
      await _firestore
          .collection('users')
          .doc(state!.id)
          .update(state!.toFirestore());
    } catch (e) {
      state = state;
    }
  }
  //end
}

final userProvider =
    StateNotifierProvider<UserProvider, UserModel?>((ref) => UserProvider());
