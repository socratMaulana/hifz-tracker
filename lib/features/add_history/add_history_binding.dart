import 'package:hifz_tracker_teacher/controllers/add_history_controller.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';

class AddHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddHistoryController());
  }
}
