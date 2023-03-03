import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarWithValue extends StatelessWidget {
  final String? value;
  final Function(double)? onChanged;
  final Color? color;
  final double? initialRating;

  const RatingBarWithValue(
      {Key? key,
        this.value,
        this.onChanged,
        this.color, this.initialRating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (value != null)
          Text( "( ${value!} ",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
        if (value != null)

          AppStyles.smallBox,
        SizedBox(
          height: 20,width: 100,
          child: FittedBox(
            fit: BoxFit.contain,
            child: RatingBar.builder(
              initialRating: initialRating ?? 4.5,
              minRating: 1,unratedColor: color ?? Colors.black,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 1),
              itemBuilder: (context, _) => const Icon(
                Icons.star_rounded,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print("rating$rating");
                // onChanged!(rating);
              },
            ),
          ),
        ),
        if (value != null)
          Text( " )",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
      ],
    );
  }
}
