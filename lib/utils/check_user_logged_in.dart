import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m0vieapp/screens/login_screen.dart';
import 'package:m0vieapp/screens/home_screen.dart';

class CheckUserLoggedIn extends StatefulWidget {
  const CheckUserLoggedIn({Key? key}) : super(key: key);

  @override
  State<CheckUserLoggedIn> createState() => _CheckUserLoggedInState();
}

class _CheckUserLoggedInState extends State<CheckUserLoggedIn> {
  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (Route<dynamic> route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
