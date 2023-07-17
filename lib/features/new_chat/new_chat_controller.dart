import '../../core_imports.dart';

class NewChatController extends BaseController {
  final students = <Map<String, dynamic>>[].obs;

  @override
  void onInit() async {
    students(Get.arguments);
    super.onInit();
  }
}
