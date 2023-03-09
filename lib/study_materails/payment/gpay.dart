
import 'dart:io';

import 'package:are_you_shipping_me/main.dart';
import 'package:are_you_shipping_me/study_materails/payment/GPayResponseModel.dart';
import 'package:are_you_shipping_me/study_materails/payment/payment_success.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
// import 'payment_configurations.dart' as payment_configurations;

class GooglePay extends StatelessWidget {
  const GooglePay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Platform.isAndroid ?
      GooglePayButton(
        paymentConfigurationAsset: 'json/gpay.json',
        paymentItems: const [
          PaymentItem(
            label: 'Total',
            amount: '10.00',
            status: PaymentItemStatus.final_price,
          )
        ],
        type: GooglePayButtonType.pay,
        margin: const EdgeInsets.only(top: 15.0,bottom: 15),
        onPaymentResult: (result) {
          gPayResponse(GPayResponse.fromJson(result));
        },
        loadingIndicator: const Center(
          child: CircularProgressIndicator(),
        ),
      ):
      ApplePayButton(
        paymentConfigurationAsset: 'json/gpay.json',
        paymentItems: const [
          PaymentItem(
            label: 'Total',
            amount: '10.00',
            status: PaymentItemStatus.final_price,
          )
        ],
        type: ApplePayButtonType.book,
        margin: const EdgeInsets.only(top: 15.0,bottom: 15),
        onPaymentResult: (result) {
          gPayResponse(GPayResponse.fromJson(result));
        },
        loadingIndicator: const Center(
          child: CircularProgressIndicator(),
        ),
      )
    );
  }
  void gPayResponse(GPayResponse gPayResponse) async {
  if(gPayResponse.paymentMethodData?.tokenizationData != null){
    loadPaymentSuccessScreen();
  }

  }
  void loadPaymentSuccessScreen() {
    Navigator.pushReplacement(
        MyApp.navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => const PaymentSuccess(),
        ));
  }

}
