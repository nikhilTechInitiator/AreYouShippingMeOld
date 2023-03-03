import 'package:are_you_shipping_me/constants/app_drawables.dart';
import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:flutter/material.dart';

class DriverDetailsTile extends StatelessWidget {
  final String? name;
  final String? email;
  final String? profile;
  final bool? isSelected;

  const DriverDetailsTile(
      {Key? key,
      this.profile,
     required this.email,
        required this.name,
      this.isSelected,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemWidget();
  }

  Widget itemWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
         color: Colors.white,
          borderRadius: BorderRadius.circular(8),
         ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
              ),
              child: Image.asset(
                profile!,
                height: 56,
                width: 56,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                 email!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),

              ],
            ),
          ),
          Icon( isSelected == true ?Icons.radio_button_checked: Icons.radio_button_off)
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
