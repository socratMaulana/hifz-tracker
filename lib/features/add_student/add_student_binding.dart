import 'package:hifz_tracker_teacher/core_imports.dart';
import 'package:hifz_tracker_teacher/controllers/add_student_controller.dart';

class AddStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddStudentController());
  }
}
