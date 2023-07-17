import 'package:flutter/material.dart';

import '../colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final Function? validator;
  final TextInputType? textInputType;
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final String? prefix;
  final String? suffix;
  final bool? readOnly;
  final int? maxLines;
  final EdgeInsets? padding;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final EdgeInsets? contentPadding;
  final Function(String value)? onChange;
  final bool? focuseBordered;
  final Function()? onTap;

  const CustomTextFormField(
      {Key? key,
      this.focusNode,
      required this.textEditingController,
      this.validator,
      this.textInputType,
      this.labelText,
      this.hintText,
      this.obscureText,
      this.prefix,
      this.suffix,
      this.readOnly,
      this.maxLines,
      this.padding,
      this.suffixIcon,
      this.prefixIcon,
      this.contentPadding,
      this.onChange,
      this.focuseBordered,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 6,
        shadowColor: Colors.blue.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          onTap: () => onTap != null ? onTap!() : null,
          focusNode: focusNode,
          controller: textEditingController,
          keyboardType: textInputType ?? TextInputType.text,
          obscureText: obscureText ?? false,
          readOnly: readOnly ?? false,

          // ignore: prefer_if_null_operators
          maxLines: maxLines == null
              ? obscureText != null && obscureText!
                  ? 1
                  : null
              : maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            prefix: Text(prefix ?? ''),
            suffix: Text(suffix ?? ''),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            labelText: labelText,
            contentPadding: contentPadding,
            focusColor: CustomColor.primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: focuseBordered != null
                      ? focuseBordered!
                          ? CustomColor.primaryColor
                          : Colors.transparent
                      : Colors.transparent),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: CustomColor.errorColor,
                ),
                borderRadius: BorderRadius.circular(8)),
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
          onChanged: ((value) => onChange != null ? onChange!(value) : null),
        ),
      ),
    );
  }
}
