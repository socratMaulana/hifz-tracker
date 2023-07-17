import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';
import 'package:hifz_tracker_teacher/features/surah_detail_screen.dart';

class SurahsScreen extends StatefulWidget {
  final String studentId;
  const SurahsScreen({super.key, required this.studentId,});

  @override
  State<SurahsScreen> createState() => _SurahsScreenState();
}

class _SurahsScreenState extends State<SurahsScreen> {
  final surahs = <Map<String, dynamic>>[].obs;
  final surahNames = <String>[].obs;

  @override
  void initState() {
    _initSurahs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.transparent(
        title: 'Surah',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: surahs.length,
          itemBuilder: (context, index) {
            final surah = surahs[index];

            return InkWell(
              onTap: () => Get.to(
                () => SurahDetailScreen(
                  studentId: widget.studentId,
                  surah: surah,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14A1A1A1),
                      spreadRadius: 1,
                      blurRadius: 16,
                      offset: Offset(0, 7), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${surah['nama']}',
                      style: CustomTextStyle.black16w700(),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _initSurahs() async {
    final String response =
        await rootBundle.loadString('assets/files/surahs.json');
    final List<dynamic> data = await json.decode(response);

    for (var element in data) {
      surahs.add(element);
      surahNames.add(element['nama']);
    }

    setState(() {});
  }
}
