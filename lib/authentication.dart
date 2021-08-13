import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn(BuildContext context) async {
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

      if (result != null) {
        Navigator.of(context).pushReplacementNamed('/dashboard');
      }
    }
  }
}