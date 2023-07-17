import 'dart:developer';

import '../core_imports.dart';

class SurahDetailScreen extends StatefulWidget {
  final String studentId;
  final Map<String, dynamic> surah;

  const SurahDetailScreen(
      {super.key, required this.studentId, required this.surah});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  final memorizedAyat = <int>{};
  final unmemorizedAyat = <int>{};

  bool isLoading = true;

  @override
  void initState() {
    _getHistories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.transparent(title: 'Detail'),
      body: isLoading
          ? const ShimmerListWidget()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      widget.surah['nama'],
                      style: CustomTextStyle.black20w400(),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CustomColor.primaryColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(
                          int.parse(widget.surah['ayat']),
                          (index) => Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: unmemorizedAyat.contains(index + 1)
                                    ? memorizedAyat.contains(index + 1)
                                        ? CustomColor.primaryColor
                                        : CustomColor.errorColor
                                    : memorizedAyat.contains(index + 1)
                                        ? CustomColor.primaryColor
                                        : Colors.transparent,
                                shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  color: memorizedAyat.contains(index + 1) ||
                                          unmemorizedAyat.contains(index + 1)
                                      ? Colors.white
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    CustomElevatedButton(
                      text: 'Kembali',
                      onPressed: () => Get.back(),
                      borderRadius: 16,
                    ),
                    const SizedBox(height: 32)
                  ],
                ),
              ),
            ),
    );
  }

  _getHistories() async {
    final firestore = FirebaseUtils().firestore;
    final response = await firestore
        .collection(Constants.historyRef)
        .where('studentId', isEqualTo: widget.studentId)
        .where('surah', isEqualTo: widget.surah['nama'])
        .get();

    for (var data in response.docs) {
      final element = data.data();
      final fromAyat = int.parse(element['fromAyat']);
      final toAyat = int.parse(element['toAyat']);

      for (var i = fromAyat; i <= toAyat; i++) {
        if (element['isFluent']) {
          memorizedAyat.add(i);
        } else {
          unmemorizedAyat.add(i);
        }
      }
    }

    setState(() {
      isLoading = false;
    });
  }
}
