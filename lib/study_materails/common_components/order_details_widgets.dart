import 'dart:io';
import 'package:are_you_shipping_me/constants/app_colors.dart';
import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:are_you_shipping_me/study_materails/common_components/order_detail_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OrderDetailsComponents extends StatelessWidget {
  const OrderDetailsComponents({Key? key}) : super(key: key);

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
              kIsWeb ? Icons.arrow_back :  Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Order Details Components',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: ListView(
        padding: AppStyles.extraSmallPadding,
        children: const [
          OrderDetailTile(
            shipmentName: "Table",
            destination: "New york",
            source: "West chester",
            dimension: "34” x 8” x 2”",
            weight: "20000 lbs",
            inTransit: true,
          ),
          OrderDetailTile(
            shipmentName: "Catoon box",
            destination: "New york",
            source: "West chester",
            dimension: "34” x 8” x 2”",
            weight: "50000 lbs lbs",
            showCancelButton: true,
            showChatButton: true,
            showStartButton: true,
            dateTime: "Pick up today",
          ),
          OrderDetailTile(
            shipmentName: "Catoon box",
            destination: "New york",
            source: "West chester",
            dimension: "34” x 8” x 2”",
            weight: "50000 lbs lbs",
            showCancelButton: true,
            showChatButton: true,
            showStartButton: false,
            dateTime: "Pick up on Feb 28, 2023",
          ),
          OrderDetailTile(
            shipmentName: "Table",
            destination: "New york",
            source: "West chester",
            dimension: "34” x 8” x 2”",
            weight: "20000 lbs",
            toBeBilled: true,
            showChatButton: true,
          ),
        ],
      ),
    );
  }
}
