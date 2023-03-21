import 'dart:io';

import 'package:are_you_shipping_me/constants/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants/app_drawables.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

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
          ' Payment',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: Center(
        child: Image.asset(AppDrawables.paymentSuccess),
      ),
    );
  }
}
