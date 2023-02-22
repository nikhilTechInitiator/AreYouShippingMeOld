import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_styles.dart';


class TextFieldBox extends StatelessWidget {
  final String hint;
  final int? minLines, maxLines;
  final TextInputType? textInputType;
  final TextEditingController textEditingController;
  final FormFieldValidator<String>? validator;
  final String? prefixIconLocation;
  final List<TextInputFormatter> inputFormatters;
  final String? label;

  const TextFieldBox({
    Key? key,
    required this.hint,
    this.prefixIconLocation,
    required this.textEditingController,
    this.minLines,
    this.maxLines,
    this.textInputType,
    this.validator,
    this.label,
    this.inputFormatters = const [],
  }) : super(key: key);

  // final FocusNode _focusNode=FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: Text(
              label!,
            ),
          ),
        if (label != null) AppStyles.extraSmallBox,
        Container(
          margin: const EdgeInsets.all(1),
          decoration: AppStyles.smallBoxDecoration,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: TextFormField(
            minLines: minLines,
            maxLines: maxLines,
            controller: textEditingController,
            // autofocus: true,
            // focusNode: _focusNode,
            style: Theme.of(context).textTheme.bodyMedium,
            validator: validator,
            enableSuggestions: true,
            autocorrect: true,
            inputFormatters: inputFormatters,
            keyboardType: textInputType,
            decoration: InputDecoration(
              counterText: '',
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              prefixIcon: prefixIconLocation != null
                  ? SvgPicture.asset(
                      prefixIconLocation!,
                      height: 24,
                      width: 24,
                      fit: BoxFit.scaleDown,
                    )
                  : null,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
