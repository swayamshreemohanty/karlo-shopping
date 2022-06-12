// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/utility/show_snak_bar.dart';

class GoogleAuthenticationRepository {
  static Future<FirebaseApp> initializeFirebase({BuildContext? context}) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ShowSnackBar.showSnackBar(
            context,
            'The account already exists with a different credential.',
          );
        } else if (e.code == 'invalid-credential') {
          ShowSnackBar.showSnackBar(
            context,
            'Error occurred while accessing credentials. Try again.',
          );
        }
      } catch (e) {
        ShowSnackBar.showSnackBar(
          context,
          'Error occurred using Google Sign-In. Try again.',
        );
      }
    }
    return user;
  }

  Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();
    } catch (e) {
      ShowSnackBar.showSnackBar(
        context,
        'Error signing out. Try again.',
      );
    }
  }
}
