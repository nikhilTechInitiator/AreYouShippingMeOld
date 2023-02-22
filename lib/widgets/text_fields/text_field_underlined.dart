import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_colors.dart';

class TextFieldUnderlined extends StatefulWidget {
  final String label;
  final String? hint;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final FormFieldValidator<String>? validator;
  final String? prefixIconLocation;
  final bool isPassword;
  final int minLine, maxLine;

  const TextFieldUnderlined({
    Key? key,
    required this.label,
    this.hint,
    this.prefixIconLocation,
    required this.textEditingController,
    this.textInputType = TextInputType.none,
    this.validator,
    this.isPassword = false,
    this.maxLine = 1,
    this.minLine = 1,
  }) : super(key: key);

  @override
  State<TextFieldUnderlined> createState() => _TextFieldUnderlinedState();
}

class _TextFieldUnderlinedState extends State<TextFieldUnderlined> {
  // final FocusNode _focusNode=FocusNode();
  bool isTextVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isTextVisible = !widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: widget.textEditingController,
      style: Theme.of(context).textTheme.bodyMedium!,
      validator: widget.validator,
      enableSuggestions: true,
      autocorrect: true,
      obscureText: !isTextVisible,
      // focusNode: _focusNode,

      decoration: InputDecoration(
        counterText: '',
        label: Text(widget.label),
        suffixIcon: widget.isPassword
            ? isTextVisible
                ? IconButton(
                    color: AppColors.lightText,
                    onPressed: () {
                      setState(() {
                        isTextVisible = !isTextVisible;
                      });
                    },
                    icon: const Icon(Icons.visibility),
                  )
                : IconButton(
                    color: AppColors.lightText,
                    onPressed: () {
                      setState(() {
                        isTextVisible = !isTextVisible;
                      });
                    },
                    icon: const Icon(Icons.visibility_off))
            : null,
        prefixIcon: widget.prefixIconLocation != null
            ? SvgPicture.asset(
                widget.prefixIconLocation!,
                height: 24,
                width: 24,
                fit: BoxFit.scaleDown,
              )
            : null,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary)),
      ),
    );
  }
}
