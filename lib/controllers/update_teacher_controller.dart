import 'package:hifz_tracker_teacher/core_imports.dart';

class UpdateTeacherController extends BaseController {
  final key = GlobalKey<FormState>();
  final fullNameCtr = TextEditingController();
  final usernameCtr = TextEditingController();
  final emailCtr = TextEditingController();

  String teacherId = '';

  updateteacher() async {
    if (!key.currentState!.validate()) return;

    try {
      isLoading(true);

      await FirebaseUtils().updateDataToFirestore(
          collection: Constants.teacherRef,
          docName: teacherId,
          data: {
            'fullName': fullNameCtr.text,
            'username': usernameCtr.text,
            'email': emailCtr.text,
            'createdAt': DateTime.now().millisecondsSinceEpoch,
          });

      isLoading(false);
      Get.back();
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  @override
  void onInit() {
    final args = Get.arguments;

    fullNameCtr.text = args['fullName'];
    usernameCtr.text = args['username'];
    emailCtr.text = args['email'];
    teacherId = args['id'];

    super.onInit();
  }
}
