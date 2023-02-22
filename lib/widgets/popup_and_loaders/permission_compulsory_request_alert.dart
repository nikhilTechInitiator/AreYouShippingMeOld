import '../../../main.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

permissionCompulsoryRequestAlert({required String requestMessage}) async {
  await showDialog(
      context: MyApp.navigatorKey.currentContext!,
      useSafeArea: true,
      builder: (context) => AlertDialog(
            insetPadding: const EdgeInsets.all(20),
            titlePadding: const EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.all(0),
            actionsPadding: const EdgeInsets.all(0),
            backgroundColor: Theme.of(context).colorScheme.surface,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Icon(
                    Icons.contacts,
                    color: Theme.of(context).colorScheme.surface,
                    size: 32,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(requestMessage),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Text(
                            "CANCEL",
                            style: Theme.of(context).textTheme.button,
                          )),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await openAppSettings();

                        Navigator.pop(MyApp.navigatorKey.currentContext!);
                      },
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Text(
                            "CONTINUE",
                            style: Theme.of(context).textTheme.button,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ));
}
