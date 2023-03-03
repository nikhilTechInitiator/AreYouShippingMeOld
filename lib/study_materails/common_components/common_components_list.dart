import 'dart:io';

import 'package:are_you_shipping_me/constants/app_colors.dart';
import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:are_you_shipping_me/study_materails/common_components/feedback_widgets.dart';
import 'package:are_you_shipping_me/study_materails/common_components/order_details_widgets.dart';
import 'package:are_you_shipping_me/study_materails/common_components/order_status_widgets.dart';
import 'package:are_you_shipping_me/study_materails/common_components/route_list_widgets.dart';
import 'package:are_you_shipping_me/study_materails/common_components/truck_driver_list_widgets.dart';
import 'package:flutter/material.dart';

class CommonComponents extends StatelessWidget {
  const CommonComponents({Key? key}) : super(key: key);

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
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderStatusComponents()));
              },
              child: const Text('Order-Status-Components')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderDetailsComponents()));
              },
              child: const Text('Order-Detail-Components')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FeedBackComponents()));
              },
              child: const Text('FeedBack-Components')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RouteListComponents()));
              },
              child: const Text('Route List Components')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TruckDriverListComponents()));
              },
              child: const Text('Trucks & Drivers List Components')),
        ],
      ),
    );
  }
}
