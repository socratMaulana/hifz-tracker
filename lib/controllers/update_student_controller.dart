import 'dart:developer';

import 'package:hifz_tracker_teacher/core_imports.dart';

class UpdateStudentController extends BaseController {
  final key = GlobalKey<FormState>();
  final fullNameCtr = TextEditingController();
  final studentNoCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final parentNameCtr = TextEditingController();

  String studentId = '';

  final classes = <Map<String, dynamic>>[].obs;
  final classNames = <String>[];
  final selectedClass = 'Kelas A'.obs;

  final semesters = <String>['1', '2'];
  final selectedSemester = '1'.obs;

  updateStudent() async {
    if (!key.currentState!.validate()) return;

    try {
      isLoading(true);

      final clas = classes
          .firstWhere((element) => element['className'] == selectedClass.value);

      await FirebaseUtils().updateDataToFirestore(
          collection: Constants.studentRef,
          docName: studentId,
          data: {
            'fullName': fullNameCtr.text,
            'studentNo': studentNoCtr.text,
            'email': emailCtr.text,
            'parentName': parentNameCtr.text,
            'classId': clas['id'],
            'semester': selectedSemester.value,
            'createdAt': DateTime.now().millisecondsSinceEpoch
          });

      isLoading(false);
      Get.back();
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  getClasses() async {
    isLoading(true);

    try {
      final classResponse =
          await FirebaseUtils().getDataFromFirestore(collection: 'classes');

      classes.clear();
      for (var element in classResponse.docs) {
        final data = element.data();
        data['id'] = element.id;

        classes.add(data);
        classNames.add(data['className']);
      }

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  @override
  void onInit() async {
    await getClasses();

    final args = Get.arguments;

    fullNameCtr.text = args['fullName'];
    studentNoCtr.text = args['studentNo'];
    parentNameCtr.text = args['parentName'];
    emailCtr.text = args['email'];
    studentId = args['id'];
    selectedClass(classes.firstWhere(
        (element) => element['id'] == args['classId'])['className']);
    selectedSemester(args['semester']);

    log(selectedClass.value);
    super.onInit();
  }
}
