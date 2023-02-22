import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:are_you_shipping_me/widgets/app_bars/app_bar_default.dart';
import 'package:are_you_shipping_me/widgets/drop_downs/all_dropdowns.dart';
import 'package:are_you_shipping_me/widgets/pickers/all_pickers.dart';
import 'package:are_you_shipping_me/widgets/text_fields/all_textfields.dart';
import 'package:flutter/material.dart';

class AllWidgets extends StatelessWidget {
  const AllWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault('All Widgets'),
      body: SingleChildScrollView(
        padding: AppStyles.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllTextFields()));
                },
                child: const Text('Text Field')), ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllDropDowns()));
                },
                child: const Text('DropDowns')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllPickers()));
                },
                child: const Text('All Pickers')),
          ],
        ),
      ),
    );
  }
}
