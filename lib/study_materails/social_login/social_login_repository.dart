import 'dart:io';

import 'package:are_you_shipping_me/constants/app_strings.dart';
import 'package:are_you_shipping_me/widgets/popup_and_loaders/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialLoginRepository {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
        showSnackBar("Signed in as ${user?.displayName}");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          debugPrint("catch :${e.code}");
          showSnackBar(" ${AppStrings.somethingWentWrong}${e.code}");
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          debugPrint("catch :${e.code}");
          showSnackBar(" ${AppStrings.somethingWentWrong}${e.code}");
          // handle the error here
        }
      } catch (e) {
        debugPrint("catch :${e.toString()}");
        showSnackBar(" ${AppStrings.somethingWentWrong}${e.toString()}");
        // handle the error here
      }
    }
    if(user == null){
      showSnackBar(" ${AppStrings.somethingWentWrong} user null");
    }
    return user;
  }
  static Future<User?> signInWithApple({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      final appleIdCredential =
      await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);
      OAuthProvider oAuthProvider = OAuthProvider("apple.com");
      final AuthCredential credential = oAuthProvider.credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode,
      );
      final UserCredential userCredential =
      await auth.signInWithCredential(credential);
      user = userCredential.user;
    }on SocketException {
      debugPrint("Socket Exception ");
      showSnackBar(" ${AppStrings.noInternetMessage}");
    } catch (onError) {
      debugPrint("Catch ${onError.toString()} ");
      showSnackBar(" ${AppStrings.somethingWentWrong}${onError.toString()}");
    }
    if(user == null){
      showSnackBar(" ${AppStrings.somethingWentWrong} user null");
    }
    return user;
  }
}