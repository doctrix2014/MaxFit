import 'package:firebase_auth/firebase_auth.dart';

class MyUser{
  late String id;
  late String errorText;
  MyUser.fromFirebase(User user){
    errorText = '';
    id = user.uid;
  }
  MyUser.error(String errorTextFromFirebase){
    errorText = errorTextFromFirebase;
    id = '';
  }
}