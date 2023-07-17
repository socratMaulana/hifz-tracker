
import '../../core_imports.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final double? elevation;
  final Color? shadowColor;

  const CustomCard({
    super.key,
    required this.child,
    this.borderRadius,
    this.elevation,
    this.shadowColor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 6,
      shadowColor: shadowColor ?? Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
      ),
      child: child,
    );
  }
}
