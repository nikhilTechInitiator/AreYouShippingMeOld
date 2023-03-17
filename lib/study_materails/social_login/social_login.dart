import 'dart:io';

import 'package:are_you_shipping_me/study_materails/social_login/social_login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_button/create_button.dart';
import 'package:sign_button/sign_button.dart';

class SocialLoginScreen extends StatefulWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  State<SocialLoginScreen> createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
              buttonType: ButtonType.facebook,imagePosition: ImagePosition.left,
              buttonSize: ButtonSize.medium,
              onPressed: () async {
                // Perform Facebook login
                final LoginResult result = await FacebookAuth.instance.login();
                if (result.status == LoginStatus.success) {
                  // User is logged in, access token is in result.accessToken.token
                  print('Facebook login successful!');
                } else {
                  // Login failed
                  print('Facebook login failed.');
                }
              },
            ),
            const SizedBox(height: 20),
            SignInButton(
              buttonType: ButtonType.google,
              buttonSize: ButtonSize.medium,
              onPressed: () async {
                // Perform Google login
               SocialLoginRepository.signInWithGoogle(context: context);
              },
            ),
            const SizedBox(height: 20),
            // if(Platform.isIOS)
              SignInButton(
              buttonType: ButtonType.apple,
              buttonSize: ButtonSize.medium,
              onPressed: () async {
                // Perform Apple login
              },
            ),
          ],
        ),
      ),
    );
  }
}
