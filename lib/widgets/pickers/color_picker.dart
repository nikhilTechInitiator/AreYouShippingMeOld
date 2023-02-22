import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../constants/app_styles.dart';
import '../../main.dart';

pickColor(Color pickerColor) async {
  Color pickedColor = pickerColor;
  Color? confirmedColor;
  await showDialog(
    context: MyApp.navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? const BorderRadius.vertical(
                      top: Radius.circular(500),
                      bottom: Radius.circular(100),
                    )
                  : const BorderRadius.horizontal(right: Radius.circular(500)),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              confirmedColor = pickedColor;
              Navigator.of(context).pop();
            },
            child: const Text('SELECT'),
          )
        ],
        content: SingleChildScrollView(
          child: HueRingPicker(
            pickerColor: pickerColor,
            onColorChanged: (color) {
              pickedColor = color;
            },
            // enableAlpha: _enableAlpha2,
            // displayThumbColor: _displayThumbColor2,
          ),
        ),
      );
    },
  );
  return confirmedColor;
}
