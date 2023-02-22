import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../constants/app_styles.dart';

showPopUp({
  String? title,
  String? message,
  String positiveLabel = 'OK',
  String negativeLabel = 'Cancel',
  GestureTapCallback? positiveButtonFunction,
  GestureTapCallback? negativeButtonAction,
  bool isNegativeButtonVisible = true,
  bool isCloseButtonVisible = true,
}) async {
  return await showDialog(
    context: MyApp.navigatorKey.currentContext!,
    useSafeArea: true,
    barrierDismissible: true,
    builder: (BuildContext context) => AlertDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      titlePadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      contentPadding: const EdgeInsets.all(0),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      actionsPadding: const EdgeInsets.all(0),
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Container(
        decoration: BoxDecoration(
          boxShadow: AppStyles.shadowSmall,
          color: Theme.of(context).colorScheme.primary,
        ),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          children: [
            if (isCloseButtonVisible)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            if (title != null)
              Text(title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      content: message != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        height: 1.2,
                      )),
            )
          : null,
      actions: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (isNegativeButtonVisible)
            ElevatedButton(
              onPressed:
                  negativeButtonAction ?? () => Navigator.of(context).pop(),
              child: Text(negativeLabel,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600)),
            ),
          if (isNegativeButtonVisible) AppStyles.largeBox,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
            onPressed:
                positiveButtonFunction ?? () => Navigator.of(context).pop(),
            child: Text(positiveLabel,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontWeight: FontWeight.w600)),
          )
        ]),
      ],
    ),
  );
}
