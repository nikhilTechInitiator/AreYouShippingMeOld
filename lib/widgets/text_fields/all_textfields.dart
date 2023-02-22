
import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';
import '../app_bars/app_bar_default.dart';
import 'text_field_box.dart';
import 'text_field_outer_lined_label.dart';
import 'text_field_outlined.dart';
import 'text_field_search.dart';
import 'text_field_underlined.dart';

class AllTextFields extends StatelessWidget {
  const AllTextFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault('All Dropdowns'),
      body: SingleChildScrollView(
        padding: AppStyles.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            TextFieldUnderlined(
              label: 'Label',
              hint:'hint',
              textEditingController: TextEditingController(),
            ),
            AppStyles.mediumBox,
            TextFieldBox(
              label: 'Label',
              textEditingController: TextEditingController(),
              hint: 'Hint',
            ),

            AppStyles.mediumBox,
            TextFieldOutlined(
              label: 'Label',
              textEditingController: TextEditingController(),
              hint: 'Hint',
            ),
            AppStyles.mediumBox,
            TextFieldOuterLinedLabel(
              label: 'Label',
              textEditingController: TextEditingController(),
              hint: 'Hint',
            ),
            AppStyles.mediumBox,
            TextFieldSearch(
              textEditingController: TextEditingController(),
            ),
          ],
        ),
      ),
    );
  }
}
