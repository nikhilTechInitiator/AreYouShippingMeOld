import '../../../main.dart';
import 'package:flutter/material.dart';

showLoader() {
  showDialog(
    context: MyApp.navigatorKey.currentContext!,
    barrierDismissible: false,
    useRootNavigator: true,
    // barrierColor: Colors.black,
    useSafeArea: true,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

hideLoader() {
  Navigator.pop(MyApp.navigatorKey.currentContext!);
}
