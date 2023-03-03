import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarWidget extends StatelessWidget {
  final String? label;
  final Function(double)? onChanged;
  final Color? color;
  final double? initialRating;

  const RatingBarWidget(
      {Key? key,
        this.label,
        this.onChanged,
        this.color, this.initialRating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (label != null)
          Text(
            label!,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
        if (label != null)

          AppStyles.smallBox,
        RatingBar.builder(
          initialRating: initialRating ?? 4.5,
          minRating: 1,unratedColor: color ?? Colors.black,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star_rounded,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print("rating$rating");
            // onChanged!(rating);
          },
        ),
      ],
    );
  }
}
