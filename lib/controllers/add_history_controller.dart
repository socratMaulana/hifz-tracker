import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';

class AddHistoryController extends BaseController {
  final addKey = GlobalKey<FormState>();
  final reviewCtr = TextEditingController();
  final fromAyatCtr = TextEditingController();
  final toAyatCtr = TextEditingController();
  final dateCtr = TextEditingController(text: Utils.getCurrentDateddMMMMyyyy());
  final timeCtr = TextEditingController(text: Utils.getCurrentTimeHHmm());

  final surahs = <Map<String, dynamic>>[].obs;
  final surahNames = <String>[].obs;

  final selectedSurah = 'Al Fatihah'.obs;
  final selectedType = 'Hafalan'.obs;

  final grades = <String>['A', 'B', 'C', 'D'];
  final selectedGrade = 'D'.obs;

  final isFluent = true.obs;

  String studentId = '';

  _initSurahs() async {
    final String response =
        await rootBundle.loadString('assets/files/surahs.json');
    final List<dynamic> data = await json.decode(response);

    for (var element in data) {
      surahs.add(element);
      surahNames.add(element['nama']);
    }
  }

  addHistory() async {
    if (!addKey.currentState!.validate()) return;

    final fromAyat = int.parse(fromAyatCtr.text);
    final toAyat = int.parse(toAyatCtr.text);

    try {
      if (fromAyat > toAyat) throw 'Masukan angka yang valid!';

      final selectedSurahData =
          surahs.firstWhere((p0) => p0['nama'] == selectedSurah.value);
      if (toAyat > int.parse(selectedSurahData['ayat'])) {
        throw 'Nomor ayat melebihi jumlah ayat!';
      }

      isLoading(true);
      final splittedTime = timeCtr.text.split(':');

      final date = DateFormat('dd MMMM yyyy, HH:mm', 'id_ID')
          .parse('${dateCtr.text}, ${splittedTime.first}:${splittedTime[1]}');

      await FirebaseUtils()
          .saveDataToFirestore(collection: Constants.historyRef, data: {
        'type': selectedType.value,
        'surah': selectedSurah.value,
        // 'ayats': selectedAyats,
        'fromAyat': fromAyatCtr.text,
        'toAyat': toAyatCtr.text,
        'score': selectedGrade.value,
        'isFluent': isFluent.value,
        'review': reviewCtr.text,
        'createdAt': date.millisecondsSinceEpoch,
        'createdDate': dateCtr.text,
        'studentId': studentId,
        'teacherId': await Utils.readFromSecureStorage(key: Constants.token)
      });

      isLoading(false);
      Get.back();
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  @override
  void onInit() async {
    studentId = Get.arguments;
    await _initSurahs();
    super.onInit();
  }
}
