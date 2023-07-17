import 'package:hifz_tracker_teacher/core_imports.dart';
import 'package:hifz_tracker_teacher/controllers/detail_student_controller.dart';

class DetailStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailStudentController());
  }
}
