import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyClickableFormField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final Function onTap;
  final TextInputType? textInputType;
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final String? prefix;
  final Function? validation;
  final List<TextInputFormatter>? formatter;

  const MyClickableFormField(
      {Key? key,
      required this.focusNode,
      required this.textEditingController,
      required this.onTap,
      this.textInputType,
      this.labelText,
      this.hintText,
      this.obscureText,
      this.prefix,
      this.validation,
      this.formatter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: IgnorePointer(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            focusNode: focusNode,
            controller: textEditingController,
            keyboardType: textInputType ?? TextInputType.visiblePassword,
            obscureText: obscureText ?? false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field harus diisi!';
              }

              if (validation != null) {
                return validation!(value);
              }

              return null;
            },
            inputFormatters: formatter,
            decoration: InputDecoration(
              hintText: hintText,
              prefix: Text(prefix ?? ''),
              labelText: labelText,
              labelStyle: TextStyle(
                  color: focusNode.hasFocus
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.grey[400]!,
                  width: 1.0,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.grey[400]!,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ),
      onTap: () => onTap(),
    );
  }
}
