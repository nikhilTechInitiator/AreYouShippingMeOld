import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_styles.dart';

class TextFieldSearch extends StatefulWidget {
  final String? searchText;
  final TextInputType? textInputType;
  final TextEditingController textEditingController;
  final ValueChanged<String>? onSubmit;
  final GestureTapCallback? onClose;
  final List<TextInputFormatter> inputFormatters;

  const TextFieldSearch({
    Key? key,
    this.searchText = 'Search ...',
    required this.textEditingController,
    this.textInputType,
    this.inputFormatters = const [],
    this.onSubmit,
    this.onClose,
  }) : super(key: key);

  @override
  State<TextFieldSearch> createState() => _TextFieldSearchState();
}

class _TextFieldSearchState extends State<TextFieldSearch> {
  // final FocusNode _focusNode=FocusNode();

  @override
  initState() {
    super.initState();
    widget.textEditingController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: const EdgeInsets.all(1),
      decoration: AppStyles.smallBoxDecoration,
      child: TextFormField(
        maxLines: 1,
        controller: widget.textEditingController,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
        enableSuggestions: true,
        autocorrect: true,
        // focusNode: _focusNode,
        inputFormatters: widget.inputFormatters,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 3),
          counterText: '',
          hintText: widget.searchText,
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          suffixIcon: widget.textEditingController.text.trim().isNotEmpty
              ? IconButton(
                  onPressed: () {
                    widget.onClose?.call();
                    widget.textEditingController.clear();
                  },
                  icon: Icon(Icons.close,
                      color: Theme.of(context).colorScheme.onSurface))
              : null,
          border: InputBorder.none,
        ),
        onFieldSubmitted: widget.onSubmit,
      ),
    );
  }
}
