import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? borderColor;
  final Color? textColor;
  final double? elevation;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? width;
  final double? height;
  final Widget? leading;

  const CustomOutlinedButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.padding,
      this.borderRadius,
      this.borderColor,
      this.textColor,
      this.elevation,
      this.fontWeight,
      this.fontSize,
      this.width,
      this.height,
      this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(elevation),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all<EdgeInsets>(
              padding ?? const EdgeInsets.all(16)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                  color: borderColor ?? Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          leading ?? const SizedBox(),
          Text(
            text,
            style: TextStyle(
                fontSize: fontSize ?? 16,
                fontWeight: fontWeight ?? FontWeight.w400,
                color: textColor ?? Theme.of(context).primaryColor),
          )
        ]),
      ),
    );
  }
}
