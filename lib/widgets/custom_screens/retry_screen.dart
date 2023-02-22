
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';


class RetryScreen extends StatelessWidget {
  const RetryScreen(
      {Key? key,
      this.message = 'Something Went Wrong',
      required this.retryAction})
      : super(key: key);

  final String message;
  final Function retryAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            'assets/retry_page_icon.svg',
            width: AppStyles().width * .5,
          ),
          AppStyles.largeBox,
          Text('Something went Wrong',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppColors.lightText.withOpacity(.6))),
          AppStyles.largeBox,
          ElevatedButton(
              onPressed: () {
                retryAction();
              },
              child: const Text('Retry')),
          AppStyles.extraLargeBox,

        ],
      ),
    );
  }
}
