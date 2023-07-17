import 'package:hifz_tracker_teacher/core_imports.dart';
import 'package:hifz_tracker_teacher/controllers/update_student_controller.dart';

class UpdateStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateStudentController());
  }
}
