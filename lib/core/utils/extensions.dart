import '../../core_imports.dart';

extension ContextExtensions on BuildContext {
  showSnackbar({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
