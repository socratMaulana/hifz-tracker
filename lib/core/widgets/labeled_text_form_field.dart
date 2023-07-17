import 'package:flutter/material.dart';

import '../colors.dart';

class CustomLabeledTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hint;
  final Function? validator;
  final TextInputType? textInputType;
  final EdgeInsets? contentPadding;
  final String? prefix;
  final TextStyle? labelStyle;
  final bool? obscureText;
  final bool readOnly;
  final double? borderRadius;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function? onTap;
  final int? maxLines;

  const CustomLabeledTextFormField(
      {super.key,
      required this.label,
      required this.controller,
      this.focusNode,
      this.hint,
      this.validator,
      this.textInputType,
      this.contentPadding,
      this.prefix,
      this.labelStyle,
      this.obscureText,
      this.readOnly = false,
      this.borderRadius,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 16),
          child: TextFormField(
            focusNode: focusNode,
            obscureText: obscureText ?? false,
            controller: controller,
            readOnly: readOnly,
            maxLines: maxLines,
            keyboardType: textInputType ?? TextInputType.name,
            onTap: onTap != null ? () => onTap!() : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 14),
              prefix: Text(prefix ?? ''),
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
              contentPadding: contentPadding,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
                borderSide: const BorderSide(
                  color: CustomColor.errorColor,
                  width: 2.0,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field harus diisi!';
              }

              if (validator != null) {
                return validator!(value);
              }

              return null;
            },
          ),
        )
      ],
    );
  }
}
