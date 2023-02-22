import 'package:are_you_shipping_me/widgets/app_bars/app_bar_default.dart';
import 'package:are_you_shipping_me/widgets/drop_downs/drop_down_outlined.dart';
import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';

class AllDropDowns extends StatelessWidget {
  AllDropDowns({Key? key}) : super(key: key);

  final List<String> itemValues = ['item1', 'item2', 'item 3'];
  final List<String> itemTexts = [
    'item Value 1',
    'item Value 3',
    'item value 3'
  ];
  final String selectedItem = 'item1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault('All Dropdowns'),
      body: SingleChildScrollView(
        padding: AppStyles.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropDownOutlined(
              itemValues: itemValues,
              selectedItem: selectedItem,
              label: 'Dropdown Label',
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
