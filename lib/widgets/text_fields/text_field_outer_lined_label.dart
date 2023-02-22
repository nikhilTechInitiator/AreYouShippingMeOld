import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_styles.dart';


class TextFieldOuterLinedLabel extends StatelessWidget {
  final String? hint;
  final int? minLines, maxLines;
  final TextInputType? textInputType;
  final TextEditingController textEditingController;
  final FormFieldValidator<String>? validator;
  final String? prefixIconLocation;
  final List<TextInputFormatter> inputFormatters;
  final String? label;
  final bool isRequired;
  final bool isLabelBold;

  final Function? onChanged;

  final String? suffixText;

  const TextFieldOuterLinedLabel({
    Key? key,
    this.hint,
    this.label,
    this.prefixIconLocation,
    required this.textEditingController,
    this.minLines,
    this.maxLines,
    this.textInputType,
    this.validator,
    this.suffixText,
    this.onChanged,
    this.isRequired = true,
    this.inputFormatters = const [],
    this.isLabelBold = false,
  }) : super(key: key);

  // final FocusNode _focusNode=FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null)
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: label!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight:
                        isLabelBold ? FontWeight.w600 : FontWeight.w500),
                children: const [
                  TextSpan(
                    text: ' *',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                  ),
                ],
              ),
            ),
          if (label != null) AppStyles.extraSmallBox,
          TextFormField(
            minLines: minLines,
            maxLines: maxLines,
            controller: textEditingController,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  height: 1.5,
                ),
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enableSuggestions: true,
            autocorrect: true,
            // focusNode: _focusNode,
            keyboardType: textInputType,
            inputFormatters: inputFormatters,
            cursorHeight: 20,
            onChanged: (value) {
              if (onChanged != null) {
                onChanged!();
              }
            },
            decoration: InputDecoration(
              counterText: '',
              hintText: hint,
              suffix: suffixText != null ? Text(suffixText!) : null,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          ),
        ],
      ),
    );
  }
}
