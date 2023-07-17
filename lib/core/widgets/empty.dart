import '../../core_imports.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          'assets/empty.png',
          height: 120,
        ),
        const SizedBox(height: 16),
        const Text(
          'No data!',
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
