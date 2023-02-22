import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_strings.dart';
import '../../../constants/app_styles.dart';
import '../../../main.dart';
import '../../../service_and_utils/date_time_utils.dart';

class TimePickerTextField extends StatelessWidget {
  final String? hint;
  final FormFieldValidator<String>? validator;
  final String label;

  TimeOfDay? timeOfDay;
  final bool isRequired;
  final Function(TimeOfDay)? onChanged;

  TimePickerTextField(
      {Key? key,
      this.hint,
      required this.label,
      this.validator,
      this.isRequired = true,
      this.onChanged,
      this.timeOfDay})
      : super(key: key);

//   @override
//   State<TimePickerTextField> createState() => _TimePickerTextFieldState();
// }
//
// class _TimePickerTextFieldState extends State<TimePickerTextField> {
  TextEditingController textEditingController = TextEditingController();

  // final FocusNode _focusNode=FocusNode();

  @override
  Widget build(BuildContext context) {
    if (timeOfDay != null) {
      DateTime dateTime = DateTimeUtils.timeAndDateToDateTime(timeOfDay!);
      textEditingController.text =
          DateFormat('hh:mm a').format(dateTime).toString();
    }
    return TextFormField(
      controller: textEditingController,
      minLines: 1,
      maxLines: 1,
      // focusNode: _focusNode,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            height: 1.5,
          ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>
          isRequired && timeOfDay == null ? AppStrings.fieldEmptyMessage : null,
      enableSuggestions: true,
      autocorrect: true,
      cursorHeight: 18,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        pickTime();
      },
      decoration: InputDecoration(
        counterText: '',
        // hintText: hint ?? label,
        alignLabelWithHint: true,

        label: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: label,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        suffixIcon: IconButton(
            icon: const Icon(Icons.access_time),
            onPressed: () async {
              pickTime();
            }),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.black.withOpacity(.8))),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
        ),
      ),
    );
  }

  pickTime() async {
    timeOfDay = await showTimePicker(
        initialTime: timeOfDay ?? TimeOfDay.now(),
        context: MyApp.navigatorKey.currentContext!);
    if (timeOfDay != null) {
      DateTime dateTime = DateTimeUtils.timeAndDateToDateTime(timeOfDay!);

      textEditingController.text =
          DateFormat('hh:mm a').format(dateTime).toString();
      if(onChanged!=null){
        onChanged!(timeOfDay!);
      }
    }
  }
}
