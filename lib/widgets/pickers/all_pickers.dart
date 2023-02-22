import 'package:are_you_shipping_me/widgets/app_bars/app_bar_default.dart';
import 'package:are_you_shipping_me/widgets/pickers/date_and_time/working_day_view.dart';
import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';
import 'date_and_time/date_picker_text_field.dart';

class AllPickers extends StatelessWidget {
  const AllPickers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault('All Pickers'),
      body: SingleChildScrollView(
        padding: AppStyles.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DatePickerTextField(
              hint: 'hint',
              label: 'Label',
            ),
            AppStyles.mediumBox,
            DatePickerTextField(
              hint: 'hint',
              label: 'label',
              horizontalContentPadding: 0,
              isShowBorderAndOutlinedLabel: false,
            ),
            AppStyles.mediumBox,
            Text('Work Time Picker'),
            WorkingDayView(
              workingDayModel: WorkingDayModel(day: "Monday", startApiKey: '', endApiKey: '')
            ),
          ],
        ),
      ),
    );
  }
}
