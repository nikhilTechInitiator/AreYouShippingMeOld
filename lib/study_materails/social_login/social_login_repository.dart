import 'dart:io';

import 'package:are_you_shipping_me/constants/app_strings.dart';
import 'package:are_you_shipping_me/widgets/popup_and_loaders/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialLoginRepository {
  static Future<User?> signInWithGoogleWeb({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    showSnackBar("Perform Google login");
    debugPrint("Perform Google login ///");
    final GoogleSignIn googleSignIn =  GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly'
      ],
      ///web client id from firebase///
      clientId: '79723746965-vne01j3nha557sflpl52ksv28e0b0a20.apps.googleusercontent.com',
    );
    // await googleSignIn.signOut();
    // await googleSignIn.signInSilently();
    debugPrint("Perform Google login 111111");
    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signInSilently();
    showSnackBar("Perform Google signIn()");
    debugPrint("Perform Google login333333333");
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      debugPrint("Perform Google login55555555");
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
      showSnackBar(" ${AppStrings.somethingWentWrong}");
    }
    return user;
  }
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    debugPrint("Perform Google login ///");
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    debugPrint("Perform Google login 111111");
    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();
    debugPrint("Perform Google login333333333");
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      debugPrint("Perform Google login55555555");
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
  void onSignIn(GoogleSignInAccount googleUser) async {
    if (googleUser != null) {
      try {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        print('ID Token: ${googleAuth.idToken}'); // Send this token to your backend to authenticate the user.
        print('Access Token: ${googleAuth.accessToken}');
        print('Name: ${googleUser.displayName}');
        print('Email: ${googleUser.email}');
        print('Profile Picture URL: ${googleUser.photoUrl}');
      } catch (error) {
        print(error);
      }
    }
  }
}