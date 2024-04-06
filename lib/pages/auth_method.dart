import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mid_quiz_minapp/LoginPage.dart';
import 'package:mid_quiz_minapp/MyHomePage.dart';


class AuthPage extends StatelessWidget {
  const AuthPage ({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();

          }else {
            return LoginPage();
          }
      },
      ),
    );
  }
}