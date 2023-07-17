import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? bgColor;
  final double? elevation;
  final double? width;
  final double? height;
  final bool isLoading;
  final Widget? prefixIcon;

  const CustomElevatedButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.textStyle,
      this.padding,
      this.borderRadius,
      this.bgColor,
      this.elevation,
      this.width,
      this.height,
      this.isLoading = false,
      this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : () => onPressed(),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(elevation),
          backgroundColor: MaterialStateProperty.all(
              bgColor ?? Theme.of(context).primaryColor),
          padding: MaterialStateProperty.all<EdgeInsets>(
              padding ?? const EdgeInsets.all(16)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
            ),
          ),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  prefixIcon ?? const SizedBox(),
                  SizedBox(width: prefixIcon != null ? 12 : 0),
                  Text(
                    text,
                    style: textStyle ??
                        const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                  ),
                ],
              ),
      ),
    );
  }
}
