import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
      );

      UserCredential result = await _auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('id', user.uid);
        await prefs.setString('email', user.email!);
        await prefs.setString('name', user.displayName!);
        await prefs.setString('photoURL', user.photoURL!);

        Navigator.of(context).pushReplacementNamed('/dashboard');
      }
    }
  }
}