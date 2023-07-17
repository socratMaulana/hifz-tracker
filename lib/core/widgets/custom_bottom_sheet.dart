import '../../core_imports.dart';

showCustomBottomSheet({required BuildContext context, required Widget child, bool? isDimissible}) {
  showModalBottomSheet(
    context: context,
    isDismissible: isDimissible ?? true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child
        ],
      ),
    ),
  );
}
