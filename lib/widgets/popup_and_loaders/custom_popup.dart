import 'package:are_you_shipping_me/main.dart';
import 'package:flutter/material.dart';

customPopup(Widget child,
    {EdgeInsetsGeometry? contentPadding,
    bool isCloseIconVisible = false}) async {
  await showDialog(
      context: MyApp.navigatorKey.currentContext!,
      useSafeArea: true,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
            insetPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            titlePadding: const EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: contentPadding ?? const EdgeInsets.all(0),
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            actionsPadding: const EdgeInsets.all(0),
            backgroundColor: Theme.of(context).colorScheme.surface,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: isCloseIconVisible
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  constraints: const BoxConstraints(),
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, bottom: 10, right: 4),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.clear)),
                            ],
                          ),
                          child,
                        ],
                      ),
                    )
                  : child,
            ),
          ));
}
