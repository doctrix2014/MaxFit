import 'package:firebase_auth/firebase_auth.dart';

import '../domain/user.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<MyUser?> signInEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return MyUser.fromFirebase(user!);
    } catch (e) {
      print(e);
      //return null;
      String error = e.toString();
      MyUser user = MyUser.error(error);
      return user;
    }
  }

  Future<MyUser?> registerInEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return MyUser.fromFirebase(user!);
    } catch (e) {
      //return null;
      String error = e.toString();
      MyUser user = MyUser.error(error);
      return user;
    }
  }

  Future logOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<MyUser?> get currentUser {
    return _firebaseAuth
        .authStateChanges()
        .map((User? user) => user != null ? MyUser.fromFirebase(user!) : null);
  }
}
