import 'package:credbud/state/auth/models/auth_result.dart';
import 'package:credbud/typedefs/user_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authenticator {
  const Authenticator();

  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';
  String get email => FirebaseAuth.instance.currentUser?.email ?? '';

  Future<AuthResult> logOut() async {
    await FirebaseAuth.instance.signOut();
    return AuthResult.loggedOut;
  }

  Future<AuthResult> signInWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String? jwtToken = await userCredential.user?.getIdToken();
      if (kDebugMode) {
        print('JWT Token is: $jwtToken');
        print('UserId is: $userId');
      }
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', userId ?? '');
      prefs.setString('token', jwtToken ?? '');

      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<void> resetPassword({required String email}) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
