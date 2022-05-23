import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AccountActivity extends StatefulWidget {
  const AccountActivity({Key? key}) : super(key: key);

  @override
  State<AccountActivity> createState() => _AccountActivityState();
}

class _AccountActivityState extends State<AccountActivity> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Logout'),
        onPressed: () {
          GoogleSignIn().signOut();
          FirebaseAuth.instance.signOut();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/');
          });
        },
      ),
    );
  }
}
