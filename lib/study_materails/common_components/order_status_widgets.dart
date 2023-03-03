import 'dart:io';
import 'package:are_you_shipping_me/constants/app_colors.dart';
import 'package:are_you_shipping_me/constants/app_drawables.dart';
import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:are_you_shipping_me/study_materails/common_components/order_status_tile.dart';
import 'package:flutter/material.dart';

class OrderStatusComponents extends StatelessWidget {
  const OrderStatusComponents({Key? key}) : super(key: key);

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
          'Order Components',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: ListView(
        padding: AppStyles.extraSmallPadding,
        children: const [
          OrderStatusTile(
            title: "Reached",
            leadingAsset: AppDrawables.reached,
            trailingAsset: AppDrawables.success,
          ),
          OrderStatusTile(
            title: "Picked Up",
            leadingAsset: AppDrawables.pickedUp,
            trailingAsset: AppDrawables.camera,
          ),
          OrderStatusTile(
              title: "In Transist", leadingAsset: AppDrawables.inTransit),
          OrderStatusTile(
            title: "Delivered",
            leadingAsset: AppDrawables.delivered,
            trailingAsset: AppDrawables.camera,
          ),
          OrderStatusTile(
              title: "On the way",
              leadingAsset: AppDrawables.reached,
              trailingButton: true,
              trailingButtonTitle: "Reached"),
        ],
      ),
    );
  }
}
