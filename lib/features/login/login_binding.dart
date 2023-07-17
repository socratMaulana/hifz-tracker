import 'package:hifz_tracker_teacher/controllers/login_controller.dart';

import '../../core_imports.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
