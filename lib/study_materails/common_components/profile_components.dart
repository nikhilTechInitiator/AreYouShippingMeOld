import 'dart:io';
import 'package:are_you_shipping_me/constants/app_colors.dart';
import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:are_you_shipping_me/study_materails/other_widgets/profile_avatar_widget.dart';
import 'package:are_you_shipping_me/widgets/pickers/media/image_picker.dart';
import 'package:flutter/material.dart';

class ProfileComponents extends StatelessWidget {
  const ProfileComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.only(left: 14, right: 10),
          icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Profile Components',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: ListView(
        padding: AppStyles.extraSmallPadding,
        children: [
          GestureDetector(
              onTap: () {
                pickImageFromGallery();
              },
              child: const ProfileAvatarWidget(size: 150))
        ],
      ),
    );
  }
}
