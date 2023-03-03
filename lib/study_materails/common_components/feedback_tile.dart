import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:are_you_shipping_me/widgets/rating_bars/rating_bar_with_value.dart';
import 'package:flutter/material.dart';

class FeedBackTile extends StatelessWidget {
  final String? profilePicAsset;
  final String? name;
  final double? ratings;
  final String? content;

  const FeedBackTile(
      {Key? key, this.profilePicAsset, this.name, this.ratings, this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemWidget();
  }

  Widget itemWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (profilePicAsset != null)
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(
                    profilePicAsset!,
                    height: 33,
                    width: 33,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              AppStyles.SBW15,
              if (name != null)
                Expanded(
                    child: Text(
                  name!,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                )),
              if (ratings != null)
                RatingBarWithValue(
                  initialRating: ratings,
                )
            ],
          ),
          if (content != null)
            Padding(
              padding: const EdgeInsets.only(left: 45),
              child: Text(
                content!,
                textAlign: TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
