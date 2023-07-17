import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';

class AddStudentController extends BaseController {
  final key = GlobalKey<FormState>();
  final fullNameCtr = TextEditingController();
  final studentNoCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final parentNameCtr = TextEditingController();

  final classes = <Map<String, dynamic>>[].obs;
  final classNames = <String>[];
  final selectedClass = ''.obs;

  final semesters = <String>['I (Satu)', 'II (Dua)'];
  final selectedSemester = 'I (Satu)'.obs;

  getClasses() async {
    isLoading(true);

    try {
      final classResponse =
          await FirebaseUtils().getDataFromFirestore(collection: 'classes');

      classes.clear();
      classNames.clear();

      selectedClass(classResponse.docs.first.data()['className']);

      for (var element in classResponse.docs) {
        final data = element.data();
        data['id'] = element.id;

        classes.add(data);
        classNames.add(data['className']);
      }

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Get.back();
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  addStudent() async {
    if (!key.currentState!.validate()) return;

    try {
      isLoading(true);

      final response = await FirebaseUtils()
          .getDataFromFirestore(collection: Constants.studentRef);

      for (var element in response.docs) {
        final data = element.data();

        if (data['studentNo'] == studentNoCtr.text) {
          throw 'Nomor Murid telah digunakan!';
        } else if (data['email'] == emailCtr.text) {
          throw 'Email telah digunakan!';
        }
      }

      final clas = classes
          .firstWhere((element) => element['className'] == selectedClass.value);

      await FirebaseUtils()
          .saveDataToFirestore(collection: Constants.studentRef, data: {
        'fullName': fullNameCtr.text,
        'studentNo': studentNoCtr.text,
        'email': emailCtr.text,
        'parentName': parentNameCtr.text,
        'classId': clas['id'],
        'semester': selectedSemester.value,
        'createdAt': DateTime.now().millisecondsSinceEpoch
      });

      await FirebaseUtils()
          .register(email: emailCtr.text, password: 'hifzDefaultMurid');

      isLoading(false);
      Get.back();
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  @override
  void onInit() {
    getClasses();
    super.onInit();
  }
}
