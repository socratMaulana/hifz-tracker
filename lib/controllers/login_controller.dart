import 'dart:developer';

import 'package:hifz_tracker_teacher/core_imports.dart';
import 'package:hifz_tracker_teacher/features/dashboard/dashboard_binding.dart';
import 'package:hifz_tracker_teacher/features/dashboard/dashboard_screen.dart';

class LoginController extends BaseController {
  final key = GlobalKey<FormState>();
  final usernameCtr = TextEditingController();
  final passwordCtr = TextEditingController();

  login() async {
    if (!key.currentState!.validate()) {
      return;
    }

    isLoading(true);
    try {
      final teacherResponse = await FirebaseUtils().getDataFromFirestoreWithArg(
        collection: Constants.teacherRef,
        arg: 'username',
        value: usernameCtr.text,
      );

      if (teacherResponse.docs.isEmpty) {
        throw 'Username / Password salah!';
      }

      final data = teacherResponse.docs.first.data();
      data['id'] = teacherResponse.docs.first.id;

      await FirebaseUtils().loginWithEmail(
        email: data['email'],
        password: passwordCtr.text,
      );

      Utils.storeToSecureStorage(key: Constants.token, data: data['id']);
      setCurrentLoggedInUser(data);

      isLoading(false);
      Get.offAll(() => const DashboardScreen(), binding: DashboardBinding());
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }
}
