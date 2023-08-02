import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assessment/repo/store_userToken.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    try {
      final UserCredential response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await UserToken.setToken(response.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signIn(
    String email,
    String password,
  ) async {
    try {
      final UserCredential response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await UserToken.setToken(response.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await UserToken.clearToken();
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
