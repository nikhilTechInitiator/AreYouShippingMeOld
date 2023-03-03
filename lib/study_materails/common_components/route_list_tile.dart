import 'package:are_you_shipping_me/constants/app_drawables.dart';
import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:flutter/material.dart';

class RouteListTile extends StatelessWidget {
  final String? dateTime;
  final String? vehicleRegNumber;
  final String? source;
  final String? destination;
  final bool? showDeleteButton;

  const RouteListTile(
      {Key? key,
      this.source,
      this.destination,
      this.vehicleRegNumber,
      this.dateTime,
      this.showDeleteButton,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemWidget();
  }

  Widget itemWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
         color: Colors.white,
          borderRadius: BorderRadius.circular(8),
         ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "$source - $destination",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              if (showDeleteButton == true)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    AppDrawables.delete,
                    height: 18,
                    width: 15,
                    fit: BoxFit.fitHeight,
                  ),
                ),
            ],
          ),
          AppStyles.SBH8,
          Row(
            children: [
              Image.asset(
                AppDrawables.calendar,
                height: 15,
                width: 15,
                fit: BoxFit.fitHeight,
              ),
              AppStyles.SBW15,
              Expanded(
                  child: Text(
                dateTime!,
                style: const TextStyle(fontSize: 12),
              )),
            ],
          ),
          AppStyles.SBH8,
          Row(
            children: [
              Image.asset(
                AppDrawables.reached,
                width: 18,
                height: 10,
                fit: BoxFit.fitHeight,
              ),
              AppStyles.SBW15,
              Expanded(
                  child: Text(
                vehicleRegNumber!,
                style: const TextStyle(fontSize: 12),
              )),
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
