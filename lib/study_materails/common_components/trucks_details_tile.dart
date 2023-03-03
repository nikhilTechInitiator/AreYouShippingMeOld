import 'package:are_you_shipping_me/constants/app_drawables.dart';
import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:flutter/material.dart';

class TruckDetailsTile extends StatelessWidget {
  final String? vehicleModel;
  final String? vehicleRegNumber;
  final String? weight;
  final String? length;
  final bool? isRadioSelected;
  final bool? isTickSelected;
  final bool? isToAssign;

   const TruckDetailsTile(
      {Key? key,
      this.weight,
      this.length,
     required this.vehicleRegNumber,
        required this.vehicleModel,
      this.isRadioSelected,
        this.isTickSelected, this.isToAssign,
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
            child: Image.asset(
              AppDrawables.reached,
              height: 21,
              width: 37,
              fit: BoxFit.fitHeight,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${vehicleModel!} / ${vehicleRegNumber!}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Text(
                     "Weight:${ weight!}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Length:${ length!}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),

              ],
            ),
          ),
         if(isToAssign != true) Icon( isRadioSelected == true ?Icons.radio_button_checked: Icons.radio_button_off),
         if(isToAssign == true) Icon( isTickSelected == true ?Icons.check_box: Icons.check_box_outline_blank)
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
