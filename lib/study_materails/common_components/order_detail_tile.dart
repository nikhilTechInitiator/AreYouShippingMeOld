import 'package:are_you_shipping_me/constants/app_drawables.dart';
import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:flutter/material.dart';

class OrderDetailTile extends StatelessWidget {
  final String? shipmentName;
  final String? dateTime;
  final String? weight;
  final String? dimension;
  final String? source;
  final String? destination;
  final bool? showStartButton;
  final bool? showCancelButton;
  final bool? showChatButton;
  final bool? inTransit;
  final bool? toBeBilled;

  const OrderDetailTile(
      {Key? key,
      required this.shipmentName,
      this.showStartButton,
      this.source,
      this.destination,
      this.weight,
      this.dimension,
      this.showCancelButton,
      this.dateTime,
      this.showChatButton,
      this.inTransit,
      this.toBeBilled})
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
          color: toBeBilled == true ? Colors.transparent : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: toBeBilled == true
              ? Border.all(
                  width: 1,
                  color: Colors.black,
                )
              : Border.all(
                  width: 0,
                  color: Colors.transparent,
                )),
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
              if (showChatButton == true)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    AppDrawables.chat,
                    height: 21,
                    width: 21,
                    fit: BoxFit.fitHeight,
                  ),
                ),
            ],
          ),
          AppStyles.SBH8,
          Row(
            children: [
              Image.asset(
                AppDrawables.shipmentSmall,
                height: 16,
                width: 16,
                fit: BoxFit.fitHeight,
              ),
              AppStyles.SBW15,
              Expanded(
                  child: Text(
                shipmentName!,
                style: const TextStyle(fontSize: 12),
              )),
            ],
          ),
          AppStyles.SBH8,
          Row(
            children: [
              Image.asset(
                AppDrawables.weight,
                height: 16,
                width: 16,
                fit: BoxFit.fitHeight,
              ),
              AppStyles.SBW15,
              Expanded(
                  child: Text(
                weight!,
                style: const TextStyle(fontSize: 12),
              )),
              if (showStartButton == true)
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: const Text(
                        "Start",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )),
              AppStyles.SBW10,
              if (showCancelButton == true)
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )),
            ],
          ),
          AppStyles.SBH8,
          if (toBeBilled != true)
            Row(
              children: [
                Image.asset(
                  AppDrawables.dimension,
                  height: 16,
                  width: 16,
                  fit: BoxFit.fitHeight,
                ),
                AppStyles.SBW15,
                Expanded(
                    child: Text(
                  dimension!,
                  style: const TextStyle(fontSize: 12),
                )),
                if (dateTime != null)
                  Text(
                    dateTime!,
                    style: const TextStyle(fontSize: 12),
                  ),
                if (inTransit == true) itemInTransit()
              ],
            ),
          if (toBeBilled == true)
            Row(
              children: [
                Image.asset(
                  AppDrawables.dollar,
                  height: 16,
                  width: 16,
                  fit: BoxFit.fitHeight,
                ),
                AppStyles.SBW15,
                const Expanded(
                    child: Text(
                  "To Be Billed",
                  style: TextStyle(fontSize: 12),
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
