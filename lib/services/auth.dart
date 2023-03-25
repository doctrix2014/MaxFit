import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../domain/user.dart';
import '../screens/authphone.dart';

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

  Future<MyUser?> signInPhone(String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider
          .credential(verificationId: verificationId, smsCode: smsCode);
      UserCredential result = await _firebaseAuth.signInWithCredential(credential);
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

  Future<String?> verifyPhoneNumber(String phoneNumber) async {
    String verification = "";
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        MyPhone.verify = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return verification;
  }

  Stream<MyUser?> get currentUser {
    return _firebaseAuth
        .authStateChanges()
        .map((User? user) => user != null ? MyUser.fromFirebase(user!) : null);
  }
}
