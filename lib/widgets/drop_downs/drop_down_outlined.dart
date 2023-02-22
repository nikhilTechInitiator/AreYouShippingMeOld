import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:flutter/material.dart';

class DropDownOutlined extends StatelessWidget {
  final List<String>? itemTexts;
  final List<String> itemValues;
  final String selectedItem;
  final String? label;
  final Function(String) onChanged;
  final FormFieldValidator<String>? validator;
  final bool isRequiredField;
  final Color? color;
  final bool isValidateAlways;

  const DropDownOutlined(
      {Key? key,
      required this.itemValues,
      this.itemTexts,
      required this.selectedItem,
      this.label,
      this.validator,
      required this.onChanged,
      this.color,
      this.isRequiredField = true,
      this.isValidateAlways = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        if (label != null)

          AppStyles.smallBox,
          Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color ?? Colors.black.withOpacity(.8))),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              value: selectedItem,
              isExpanded: true,
              elevation: 1,
              validator: isRequiredField ? validator : null,
              autovalidateMode: isValidateAlways
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(border: InputBorder.none),
              style: Theme.of(context).textTheme.bodyMedium,
              items: itemValues.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    itemTexts != null
                        ? itemTexts![itemValues.indexOf(value)]
                        : value,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
