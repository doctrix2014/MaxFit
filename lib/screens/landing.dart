import 'package:flutter/material.dart';
import 'package:maxfit/screens/auth.dart';
import 'package:maxfit/screens/authphone.dart';
import 'package:maxfit/screens/home.dart';
import 'package:provider/provider.dart';

import '../domain/user.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<MyUser?>(context);
    final bool isLoggedIn = user != null;
    return isLoggedIn ? HomePage() : MyPhone();
  }
}
