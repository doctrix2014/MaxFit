import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maxfit/screens/authphone.dart';
import 'package:maxfit/screens/home.dart';
import 'package:maxfit/screens/landing.dart';
import 'package:maxfit/screens/verify.dart';
import 'package:maxfit/services/auth.dart';
import 'package:provider/provider.dart';
import 'domain/user.dart';
import 'firebase_options.dart';
import 'dart:io' show Platform;

// void main() {
//   runApp(MaxFitApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
  }else {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
  runApp(MaxFitApp());
}

class MaxFitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
        value: AuthService().currentUser,
        initialData: null,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              'phone': (context) => MyPhone(),
              'verify': (context) => MyVerify(),
              'home': (context) => HomePage()
            },
            title: 'Max Fitness',
            theme: ThemeData(
                primaryColor: const Color.fromRGBO(50, 65, 85, 1),
                textTheme: const TextTheme(
                    titleLarge: TextStyle(color: Colors.white),
                    titleMedium: TextStyle(color: Colors.white),
                    titleSmall: TextStyle(color: Colors.white))),
            home: const LandingPage()));
  }
}
