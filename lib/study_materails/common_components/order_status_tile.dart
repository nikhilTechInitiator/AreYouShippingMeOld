import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:flutter/material.dart';

class OrderStatusTile extends StatelessWidget {
  final String? leadingAsset;
  final String? title;
  final String? trailingAsset;
  final bool? trailingButton;
  final String? trailingButtonTitle;

  const OrderStatusTile(
      {Key? key,
      this.leadingAsset,
      this.title,
      this.trailingAsset,
      this.trailingButton,
      this.trailingButtonTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemWidget();
  }

  Widget itemWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (leadingAsset != null)
            Image.asset(
              leadingAsset!,
              height: 16,
              width: 28,
              fit: BoxFit.fitHeight,
            ),
          AppStyles.SBW20,
          if (title != null)
            Expanded(
                child: Text(
              title!,
              style: const TextStyle(fontSize: 15),
            )),
          if (trailingAsset != null)
            Image.asset(
              trailingAsset!,
              height: 20,
              width: 28,
              fit: BoxFit.fitHeight,
            ),
          if (trailingButton == true && trailingButtonTitle != null)
            GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    trailingButtonTitle!,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )),
        ],
      ),
    );
  }
}
