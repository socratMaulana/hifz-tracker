import 'package:hifz_tracker_teacher/core_imports.dart';

import '../../controllers/add_teacher_controller.dart';

class AddTeacherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTeacherController());
  }
}
