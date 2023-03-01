import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:are_you_shipping_me/widgets/app_bars/app_bar_default.dart';
import 'package:are_you_shipping_me/widgets/rating_bars/rating_bar.dart';
import 'package:are_you_shipping_me/widgets/rating_bars/rating_bar_with_value.dart';
import 'package:flutter/material.dart';

class AllRatingBars extends StatelessWidget {
  const AllRatingBars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault('All Rating Bars'),
      body: SingleChildScrollView(
        padding: AppStyles.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
             RatingBarWidget(label: "Rate your delivery by John."),
            AppStyles.extraLargeBox,
            Divider(height: 2,color: Colors.black,),
            AppStyles.mediumBox,
            AppStyles.mediumBox,
            AppStyles.mediumBox,
            AppStyles.mediumBox,
            RatingBarWithValue(color:Colors.transparent,value: "4.5" ),
            AppStyles.mediumBox,
          ],
        ),
      ),
    );
  }
}