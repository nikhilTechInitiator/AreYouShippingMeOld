import 'dart:io';
import 'package:are_you_shipping_me/constants/app_colors.dart';
import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:are_you_shipping_me/study_materails/slider_with_circle.dart';
import 'package:are_you_shipping_me/study_materails/slider_with_imagae.dart';
import 'package:flutter/material.dart';

class ImageSliderListComponents extends StatelessWidget {
  const ImageSliderListComponents({Key? key}) : super(key: key);

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
          'Image Slider List Components',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: ListView(
        padding: AppStyles.extraSmallPadding,
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Text(
              'Weight :',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
          AppStyles.SBH20,
          SliderWithImage(
              label: "lbs", interval: 10000, maxValue: 60000, stepSize: 10),
          AppStyles.SBH20,
          AppStyles.SBH20,
          AppStyles.thickSmallDivider,
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Text(
              'Distance Radius :',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
          AppStyles.SBH20,
          SliderWithImage(
              label: "mile", interval: 50, maxValue: 300, stepSize: 5),
          AppStyles.SBH20,
          AppStyles.SBH20,
          AppStyles.thickSmallDivider,
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Text(
              'Shipment Details progress bar :',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
          AppStyles.SBH20,
          SliderWithCircle(
               interval: 10, maxValue: 20, stepSize: 10),
        ],
      ),
    );
  }
}
