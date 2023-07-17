import 'package:hifz_tracker_teacher/core_imports.dart';

class AddTeacherController extends BaseController {
  final key = GlobalKey<FormState>();
  final fullNameCtr = TextEditingController();
  final usernameCtr = TextEditingController();
  final emailCtr = TextEditingController();

  addteacher() async {
    if (!key.currentState!.validate()) return;

    try {
      isLoading(true);

      await FirebaseUtils()
          .saveDataToFirestore(collection: Constants.teacherRef, data: {
        'fullName': fullNameCtr.text,
        'username': usernameCtr.text,
        'email': emailCtr.text,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'isAdmin': false
      });

      await FirebaseUtils()
          .register(email: emailCtr.text, password: 'hifzDefaultGuru');

      isLoading(false);
      Get.back();
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }
}
