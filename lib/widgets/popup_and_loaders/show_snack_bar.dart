import 'package:flutter/material.dart';

import '../../../main.dart';

showSnackBar(String message) {
  ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!)
      .showSnackBar(SnackBar(
    content: Text(
      message,
    ),
  ),);
}
