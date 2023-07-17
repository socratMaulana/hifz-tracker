import 'package:hifz_tracker_teacher/core_imports.dart';
import 'package:hifz_tracker_teacher/controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}
