import 'dart:io';
import 'package:are_you_shipping_me/constants/app_colors.dart';
import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:are_you_shipping_me/study_materails/common_components/feedback_widgets.dart';
import 'package:are_you_shipping_me/study_materails/common_components/image_slider_list_widgets.dart';
import 'package:are_you_shipping_me/study_materails/common_components/order_details_widgets.dart';
import 'package:are_you_shipping_me/study_materails/common_components/order_status_widgets.dart';
import 'package:are_you_shipping_me/study_materails/common_components/profile_components.dart';
import 'package:are_you_shipping_me/study_materails/common_components/route_list_widgets.dart';
import 'package:are_you_shipping_me/study_materails/common_components/truck_driver_list_widgets.dart';
import 'package:are_you_shipping_me/study_materails/common_components/user_type_widgets.dart';
import 'package:are_you_shipping_me/study_materails/payment/gpay.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/pickers/documents/download_open_file.dart';
import '../social_login/social_login.dart';

class CommonComponents extends StatefulWidget {
  const CommonComponents({Key? key}) : super(key: key);

  @override
  State<CommonComponents> createState() => _CommonComponentsState();
}

class _CommonComponentsState extends State<CommonComponents> {

  @override
  void initState() {
    // TODO: implement initState
   if(!kIsWeb) initialiser();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    disposeMethod();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.only(left: 14, right: 10),
          icon:  Icon(
          kIsWeb ? Icons.arrow_back : Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
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

        padding: AppStyles.largePadding,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderStatusComponents()));
              },
              child: const Text('Order-Status-Components')),
          AppStyles.SBH8,
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderDetailsComponents()));
              },
              child: const Text('Order-Detail-Components')),
          AppStyles.SBH8,
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FeedBackComponents()));
              },
              child: const Text('FeedBack-Components')),
          AppStyles.SBH8,
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RouteListComponents()));
              },
              child: const Text('Route List Components')),
          AppStyles.SBH8,
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const TruckDriverListComponents()));
              },
              child: const Text('Trucks & Drivers List Components')),
          AppStyles.SBH8,
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const ImageSliderListComponents()));
              },
              child: const Text('Image Sliders')),
          AppStyles.SBH8,
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const ProfileComponents()));
              },
              child: const Text('Profile Components')),
          AppStyles.SBH8,
          const GooglePay(),
          AppStyles.SBH8,
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const UserTypeComponents()));
              },
              child: const Text('User Types')),
          AppStyles.SBH8,
          ElevatedButton(
              onPressed: () {
                // download(url: 'https://drive.google.com/file/d/1JEH9tnKl_1c3oo5DBJ3XwFzRU_WjtlB8/view?usp=share_link',fileNameWithExtension: 'sample ${DateFormat('MMddyyyy hhmmss').format(DateTime.now())}.pdf',isShowSnackBar: true);
              },
              child: const Text('Download From Url')),
          AppStyles.SBH8,
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const SocialLoginScreen()));
              },
              child: const Text('Social Login')),
        ],
      ),
    );
  }
}
