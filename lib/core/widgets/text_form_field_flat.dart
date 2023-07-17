import 'package:flutter/material.dart';

import '../colors.dart';
import '../themes/custom_text_theme.dart';

class CustomTextFormFieldFlat extends StatelessWidget {
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
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final EdgeInsets? contentPadding;
  final Function? onChange;
  final bool? focuseBordered;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? height;
  final Function? onTap;

  const CustomTextFormFieldFlat({
    Key? key,
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
    this.backgroundColor,
    this.borderRadius,
    this.height,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: padding ?? const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: CustomColor.colorF6,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        focusNode: focusNode,
        controller: textEditingController,
        keyboardType: textInputType ?? TextInputType.text,
        obscureText: obscureText ?? false,
        readOnly: readOnly ?? false,
        onTap: onTap != null ? () => onTap!() : null,
        // ignore: prefer_if_null_operators
        maxLines: maxLines == null
            ? obscureText != null && obscureText!
                ? 1
                : null
            : maxLines,
        decoration: InputDecoration(
          filled: true,
          fillColor: backgroundColor ?? Colors.transparent,
          hintText: hintText,
          hintStyle: CustomTextStyle.grey(),
          prefix: Text(prefix ?? ''),
          suffix: Text(suffix ?? ''),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          labelText: labelText,
          contentPadding: contentPadding,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: focuseBordered != null
                    ? focuseBordered!
                        ? CustomColor.primaryColor
                        : Colors.transparent
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: CustomColor.errorColor,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 8)),
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
    );
  }
}
