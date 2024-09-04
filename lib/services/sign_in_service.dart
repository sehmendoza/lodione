import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Attempts to sign in a user with a username and password.
  ///
  /// The username is first converted to an email via Firestore lookup,
  /// then Firebase Authentication is used for signing in.
  Future<User?> signInWithUsernameAndPassword(
      String username, String password) async {
    try {
      // Fetch email from Firestore using username
      var querySnapshot = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data();
        String email = userData['email'];

        // Sign in with email and password
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        return userCredential.user;
      } else {
        throw Exception('Username not found');
      }
    } on FirebaseAuthException catch (e) {
      // Re-throw with a more user-friendly message or handle as needed
      throw Exception(_handleAuthError(e));
    } catch (e) {
      // General catch for any other unexpected errors
      throw Exception('Failed to sign in: $e');
    }
  }

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
        return 'Invalid username or password.';
      case 'too-many-requests':
        return 'Too many login attempts. Try again later.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
