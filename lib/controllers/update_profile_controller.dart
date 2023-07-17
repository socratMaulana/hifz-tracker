import 'dart:convert';

import 'package:hifz_tracker_teacher/core_imports.dart';

class UpdateProfileController extends BaseController {
  final key = GlobalKey<FormState>();
  final fullNameCtr = TextEditingController();
  final usernameCtr = TextEditingController();
  final emailCtr = TextEditingController();

  String teacherId = '';

  updateProfile() async {
    if (!key.currentState!.validate()) return;

    try {
      isLoading(true);

      final request = {
        'fullName': fullNameCtr.text,
        'username': usernameCtr.text,
        'email': emailCtr.text,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      };

      await FirebaseUtils().updateDataToFirestore(
          collection: Constants.teacherRef, docName: teacherId, data: request);

      request['id'] = teacherId;
      setCurrentLoggedInUser(request);

      isLoading(false);
      Get.back(result: true);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  @override
  void onInit() async {
    final userString =
        await Utils.readFromSecureStorage(key: Constants.userData);
    final args = jsonDecode(userString!);

    fullNameCtr.text = args['fullName'];
    usernameCtr.text = args['username'];
    emailCtr.text = args['email'];
    teacherId = args['id'];

    super.onInit();
  }
}
