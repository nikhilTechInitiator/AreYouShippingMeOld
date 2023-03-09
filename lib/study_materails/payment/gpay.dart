
import 'dart:io';

import 'package:are_you_shipping_me/main.dart';
import 'package:are_you_shipping_me/study_materails/payment/GPayResponseModel.dart';
import 'package:are_you_shipping_me/study_materails/payment/payment_success.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
/// Copyright 2023 Google LLC
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     https://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

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
