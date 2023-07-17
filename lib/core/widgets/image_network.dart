import '../../core_imports.dart';

class CustomImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final double? radius;

  const CustomImageNetwork(
      {super.key,
      required this.imageUrl,
      this.width,
      this.height,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width ?? 115,
        height: height ?? 115,
        fit: BoxFit.cover,
        placeholder: (context, url) => Image.asset(
          Constants.icLogo,
          width: width ?? 115,
          height: height ?? 115,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
