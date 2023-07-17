import 'package:hifz_tracker_teacher/core_imports.dart';

class CustomOutlinedTextFormField extends StatelessWidget {
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
  final Function? onChange;
  final bool? focuseBordered;

  const CustomOutlinedTextFormField(
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
      this.focuseBordered})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        focusNode: focusNode,
        controller: textEditingController,
        keyboardType: textInputType ?? TextInputType.visiblePassword,
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
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.grey[400]!,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
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
        onChanged: ((value) => onChange != null ? onChange!(value) : null),
      ),
    );
  }
}
