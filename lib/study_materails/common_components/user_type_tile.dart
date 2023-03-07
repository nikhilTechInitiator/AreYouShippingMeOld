import 'package:are_you_shipping_me/constants/app_drawables.dart';
import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:flutter/material.dart';

class OrderTypeTile extends StatelessWidget {
  final String? userType;
  const OrderTypeTile(
      {Key? key,  this.userType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemWidget();
  }

  Widget itemWidget() {
    return Container(
      width: double.infinity,
      padding: userType != null ? const EdgeInsets.symmetric(horizontal: 25, vertical: 26) :const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
                  width: 0,
                  color: Colors.transparent,
                )),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Text(
            userType ?? "Consumer & \nSupplier" ,
            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
          ),
        if(userType == "Consumer")  Image.asset(
            AppDrawables.consumer,
            height: 74,
            width: 88,
            fit: BoxFit.fitHeight,
          ),
          if(userType == "Supplier")  Image.asset(
            AppDrawables.supplier,
            height: 70,
            width: 140,
            fit: BoxFit.fitWidth,
          ),
          if(userType == null)  Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppDrawables.consumer,
                height: 65,
                width: 55,
                fit: BoxFit.fitWidth,
              ),
              Image.asset(
                AppDrawables.supplier,
                height: 47,
                width: 90,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemInTransit() {
    return Row(
      children: [
        Image.asset(
          AppDrawables.inTransit,
          height: 16,
          width: 16,
        ),
        AppStyles.SBW15,
        const Text(
          "In transit",
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
