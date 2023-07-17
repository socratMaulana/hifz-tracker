import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';

class ForgotPasswordControler extends BaseController {
  final key = GlobalKey<FormState>();
  final emailCtr = TextEditingController();

  final verifyKey = GlobalKey<FormState>();
  final verificationCodeCtr = TextEditingController();
  final newPasswordCtr = TextEditingController();

  final showCodeTextfield = false.obs;

  sendResetPasswordEmail() async {
    try {
      if (!key.currentState!.validate()) return;

      isLoading(true);

      final response = await FirebaseUtils().getDataFromFirestoreWithArg(
          collection: Constants.teacherRef, arg: 'email', value: emailCtr.text);
      if (response.docs.isEmpty) throw 'User tidak ditemukan!';

      await FirebaseUtils().auth.sendPasswordResetEmail(email: emailCtr.text);

      isLoading(false);
      showCodeTextfield(true);

      Get.back();
      Utils.showGetSnackbar('Silahkan cek email / spam anda!', true);
    } on FirebaseException catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }
}
