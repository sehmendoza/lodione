import 'package:flutter/material.dart';
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
        state = UserModel.fromFirestore(userDoc.data()!);
      } else {
        state = null;
      }
    } catch (e) {
      print('Failed to fetch user: $e');
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
      print('Failed to update user: $e');
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
      print('Failed to update user: $e');
    }
  }
  //end
}

final userProvider =
    StateNotifierProvider<UserProvider, UserModel?>((ref) => UserProvider());
