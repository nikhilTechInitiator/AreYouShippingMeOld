import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldOutlined extends StatelessWidget {
  final String? hint;
  final int? minLines, maxLines;
  final TextInputType? textInputType;
  final TextEditingController textEditingController;
  final FormFieldValidator<String>? validator;
  final String? prefixIconLocation;
  final List<TextInputFormatter> inputFormatters;
  final String label;
  final bool isRequiredField;
  final String? suffixText;
  final Color? errorBorderColor;
  final bool? autoValidate;
  final int? maxLength;

  const TextFieldOutlined(
      {Key? key,
      this.hint,
      required this.label,
      this.prefixIconLocation,
      required this.textEditingController,
      this.minLines,
      this.maxLines,
      this.textInputType,
      this.validator,
      this.isRequiredField = true,
      this.suffixText,
      this.inputFormatters = const [],
      this.errorBorderColor,
      this.autoValidate,
      this.maxLength})
      : super(key: key);

  // final FocusNode _focusNode=FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(

        keyboardType: textInputType,
        minLines: minLines,
        maxLines: maxLines,
        controller: textEditingController,
        autovalidateMode: autoValidate == true
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        // focusNode: _focusNode,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              height: 1.5,
            ),
        validator: validator,
        enableSuggestions: true,
        autocorrect: true,
        inputFormatters: inputFormatters,
        cursorHeight: 18,
        maxLength: maxLength,

        decoration: InputDecoration(
          counterText: '',
          // hintText: hint ?? label,
          alignLabelWithHint: true,
          errorStyle: TextStyle(fontSize: errorBorderColor != null ? 0 : 14),

          fillColor: Colors.white,
          label: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
                text: label,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(.7)),
                children: [
                  if (isRequiredField)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    )
                ]),
          ),
          suffixText: suffixText,
          contentPadding: EdgeInsets.symmetric(
              horizontal: 12, vertical: errorBorderColor != null ? 4 : 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.black.withOpacity(.8))),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(
                color: errorBorderColor ?? Colors.black.withOpacity(.5)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(
                color: errorBorderColor ?? Colors.black.withOpacity(.5)),
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
    );
  }
}
