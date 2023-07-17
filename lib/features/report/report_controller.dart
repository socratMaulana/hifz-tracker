import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';

class ReportController extends BaseController {
  final student = <String, dynamic>{}.obs;
  final histories = <Map<String, dynamic>>[].obs;

  final isInit = true.obs;

  final surahs = <Map<String, dynamic>>[].obs;

  String studentId = '';

  _initSurahs() async {
    final String response =
        await rootBundle.loadString('assets/files/surahs.json');
    final List<dynamic> data = await json.decode(response);

    for (var element in data) {
      element['isSelected'] = false;

      surahs.add(element);
    }
  }

  List<Map<String, dynamic>> getPickedSurahs() {
    return surahs.where((p0) => p0['isSelected']).toList();
  }

  getDatas() async {
    isLoading(true);

    try {
      final studentResponse = await FirebaseUtils().getDataFromFirestoreById(
          collection: Constants.studentRef, id: studentId);
      final historyResponse = await FirebaseUtils()
          .firestore
          .collection(Constants.historyRef)
          .where('studentId', isEqualTo: studentId)
          .orderBy('createdAt', descending: true)
          .get();

      final studentData = studentResponse.data();
      final classResponse = await FirebaseUtils().getDataFromFirestoreById(
          collection: 'classes', id: studentData!['classId']);

      studentData['className'] = classResponse.data()!['className'];
      student(studentData);

      histories.clear();
      for (var element in historyResponse.docs) {
        final data = element.data();
        histories.add(data);
      }

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Get.back();
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  String getScores({required String surahName}) {
    int scores = 0;
    int totalScore = 0;

    final score = <String, int>{'A': 10, 'B': 8, 'C': 60, 'D': 4};

    final surahHistory = histories.where((p0) => p0['surah'] == surahName);
    surahHistory.forEach((element) {
      totalScore += 1;
      scores += score[element['score']]!;
    });

    final avgScore = scores / totalScore;

    if(avgScore > 8 && avgScore <= 10 ) {
      return 'A';
    } else if (avgScore > 6 && avgScore <= 8) {
      return 'B';
    } else if(avgScore > 5 && avgScore <= 6 ) {
      return 'C';
    } else {
      return 'D';
    }

  }

  @override
  void onInit() {
    studentId = Get.arguments;
    _initSurahs();

    getDatas();
    super.onInit();
  }
}
