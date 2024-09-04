import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/sign_in_service.dart';

class UseristProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final SignInService _signInService = SignInService();

  Map<String, dynamic>? _userData;

  Map<String, dynamic>? get userData => _userData;

  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        _userData = doc.data() as Map<String, dynamic>;
      } else {
        _userData = null; // or initialize with default values
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching user data: $e');
      // Handle error appropriately
    }
  }

  Future<User?> signIn(String username, String password) async {
    try {
      var user = await _signInService.signInWithUsernameAndPassword(
          username, password);
      notifyListeners();
      return user;
    } catch (e) {
      // Handle or rethrow the exception
      rethrow;
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();

    _userData = null;
  }

  void updateUser(Map<String, dynamic> data) {
    _userData = data;
    notifyListeners();
  }
}
