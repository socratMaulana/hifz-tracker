import 'package:hifz_tracker_teacher/core_imports.dart';

import '../../controllers/update_teacher_controller.dart';

class UpdateTeacherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateTeacherController());
  }
}
