import 'package:hifz_tracker_teacher/controllers/forgot_password_controller.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordControler());
  }
}
