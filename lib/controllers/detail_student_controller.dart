import 'dart:developer';

import 'package:hifz_tracker_teacher/core_imports.dart';

class DetailStudentController extends BaseController {
  final selectedDateCtr =
      TextEditingController(text: Utils.getCurrentDateddMMMMyyyy());

  final masterHistories = <Map<String, dynamic>>[].obs;
  final histories = <Map<String, dynamic>>[].obs;
  final student = <String, dynamic>{}.obs;

  final selectedType = 'Hafal'.obs;

  getStudentHistory() async {
    isLoading(true);

    FirebaseUtils()
        .firestore
        .collection(Constants.historyRef)
        .where('studentId', isEqualTo: student['id'])
        .where('createdDate', isEqualTo: selectedDateCtr.text)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      masterHistories.clear();
      histories.clear();

      for (var element in event.docs) {
        final data = element.data();
        data['id'] = element.id;

        final fromAyat = int.parse(data['fromAyat']);
        final toAyat = int.parse(data['toAyat']);
        final ayats = <int>[];

        for (var i = fromAyat; i <= toAyat; i++) {
          ayats.add(i);
        }

        data['ayats'] = ayats;
        masterHistories.add(data);
        histories.add(data);
      }

      filterHistory();

      isLoading(false);
    }).onError((e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    });
  }

  filterHistory() {
    histories(
      masterHistories
          .where((p0) => p0['isFluent'] == (selectedType.value == 'Hafal'))
          .toList(),
    );
  }

  @override
  void onInit() {
    student(Get.arguments);
    getStudentHistory();
    super.onInit();
  }
}
