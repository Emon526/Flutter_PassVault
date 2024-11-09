import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.isRequired,
    required this.fieldTitle,
    required this.controller,
    required this.textInputAction,
    this.textCapitalization,
    required this.keyboardType,
    this.validator,
    this.obscureText,
    this.decoration,
    this.onFieldSubmitted,
    this.maxLines,
    this.focusNode,
  });
  final bool isRequired;
  final String fieldTitle;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextCapitalization? textCapitalization;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final InputDecoration? decoration;
  final void Function(String)? onFieldSubmitted;
  final int? maxLines;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(fieldTitle, style: Theme.of(context).textTheme.titleMedium),
            isRequired
                ? Text(
                    '*',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.red),
                  )
                : SizedBox()
          ],
        ),
        TextFormField(
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          obscureText: obscureText ?? false,
          decoration: decoration,
          maxLines: maxLines ?? 1,
          focusNode: focusNode,
        ),
      ],
    );
  }
}
