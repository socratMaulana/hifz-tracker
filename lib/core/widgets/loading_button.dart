import '../../core_imports.dart';

class LoadingButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isLoading;
  final Color? loadingColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? bgColor;
  final Color? textColor;
  final double? elevation;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? width;
  final double? height;

  const LoadingButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.isLoading,
      this.padding,
      this.borderRadius,
      this.bgColor,
      this.textColor,
      this.elevation,
      this.fontWeight,
      this.fontSize,
      this.width,
      this.height,
      this.loadingColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(elevation),
          backgroundColor: MaterialStateProperty.all(
              bgColor ?? Theme.of(context).primaryColor),
          padding: MaterialStateProperty.all<EdgeInsets?>(padding),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
            ),
          ),
        ),
        child: isLoading
            ? CircularProgressIndicator(
                color: loadingColor,
              )
            : Text(
                text,
                style: TextStyle(
                    fontSize: fontSize ?? 16,
                    fontWeight: fontWeight ?? FontWeight.w400,
                    color: textColor ?? Colors.white),
              ),
      ),
    );
  }
}
