import '../../core_imports.dart';

class ShimmerDetail extends StatelessWidget {
  const ShimmerDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 160,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Container(
              width: 80,
              height: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
