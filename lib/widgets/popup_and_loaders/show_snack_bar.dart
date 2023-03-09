import 'package:are_you_shipping_me/main.dart';
import 'package:flutter/material.dart';

import '../../constants/app_strings.dart';

showSnackBar(String message, {GestureTapCallback? action}) {
  debugPrint("action ${action}");
  ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!)
      .showSnackBar(SnackBar(
    action: action != null
        ? SnackBarAction(
        label: AppStrings.clickToOpen,
        disabledTextColor: Colors.white,
        textColor: Theme.of(MyApp.navigatorKey.currentContext!)
            .colorScheme
            .primary,
        onPressed: action)
        : null,
    content: Text(message, textAlign: TextAlign.start),
  ));
}