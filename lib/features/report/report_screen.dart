import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';
import 'package:hifz_tracker_teacher/features/report/report_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class ReportScreen extends GetView<ReportController> {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.transparent(
          titleWidget:
              Text(controller.isInit.value ? 'Pilih Surah' : 'Rapor Murid'),
          actions: [
            Obx(
              () => Visibility(
                visible: controller.surahs
                        .where((p0) => p0['isSelected'])
                        .isNotEmpty &&
                    controller.isInit.value,
                child: IconButton(
                  onPressed: () {
                    controller.isInit(false);
                    controller.surahs
                        .removeWhere((element) => !element['isSelected']);
                  },
                  icon: const Icon(Icons.done),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: !controller.isInit.value,
                child: IconButton(
                  onPressed: () => _buildPdf(),
                  icon: const Icon(Icons.print_outlined),
                ),
              ),
            )
          ]),
      body: Obx(
        () => controller.isLoading.value
            ? const ShimmerListWidget()
            : controller.isInit.value
                ? _buildPickSurah()
                : _buildReport(),
      ),
    );
  }

  Widget _buildPickSurah() {
    return ListView.separated(
      itemCount: controller.surahs.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final surah = controller.surahs[index];

        return CheckboxListTile(
          title: Text(
            surah['nama'],
            style: CustomTextStyle.black16w700(),
          ),
          value: surah['isSelected'],
          onChanged: (value) {
            controller.surahs[index]['isSelected'] = value;
            controller.surahs.refresh();
          },
        );
      },
    );
  }

  Widget _buildReport() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: RefreshIndicator(
          onRefresh: () => controller.getDatas(),
          child: ListView(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/logo_skl.png',
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'YAYASAN PP DARUSSALAM SAMPIT',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'MIS TAHFIDZ DARUSSALAM',
                          style: CustomTextStyle.black16w700(),
                        ),
                        Text(
                          'NSM: 111262020030 / NPSN: 70026175',
                          style: CustomTextStyle.black8w600(height: 1.5),
                        ),
                        Text(
                          'Jalan Ir.Soekarno No. 142 RT.41, RW.14, Desa Sawahan',
                          style: CustomTextStyle.black8w600(height: 1.5),
                        ),
                        Text(
                          'Kec. MB Ketapang Kab. Kotawaringin Timur Prov. Kalimantan Tengah',
                          style: CustomTextStyle.black8w600(height: 1.5),
                        ),
                        RichText(
                          text: TextSpan(
                              style: CustomTextStyle.black8w600(height: 1.5),
                              children: const [
                                TextSpan(
                                  text: 'Email: ',
                                ),
                                TextSpan(
                                  text: 'mitahfidzdarussalamspt@gmail.com',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                                TextSpan(
                                  text: ' / No. HP: 0895338582715',
                                ),
                              ]),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const Divider(
                thickness: 4,
                color: Colors.black,
              ),
              const SizedBox(height: 24),
              Text(
                'LAPORAN HASIL BELAJAR',
                style: CustomTextStyle.black12w600(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _buildRowItem(labels: [
                'Siswa',
                'Kelas'
              ], values: [
                controller.student['fullName'],
                controller.student['className']
              ]),
              _buildRowItem(labels: [
                'Induk / NISN',
                'Semester'
              ], values: [
                controller.student['studentNo'],
                controller.student['semester']
              ]),
              _buildRowItem(labels: [
                'Madrasah',
                'Tahun Pelajaran'
              ], values: [
                'MI Tahfidz Darussalam',
                '${DateTime.now().year - 1} / ${DateTime.now().year}'
              ]),
              const SizedBox(height: 32),
              _buildTable(),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    Table(
                      columnWidths: const {
                        0: FixedColumnWidth(64),
                        1: FixedColumnWidth(12),
                        2: FixedColumnWidth(72)
                      },
                      children: [
                        TableRow(children: [
                          Text(
                            'Diberikan di',
                            style: CustomTextStyle.black10w600(),
                          ),
                          Text(
                            ':',
                            style: CustomTextStyle.black10w600(),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Sampit',
                            style: CustomTextStyle.black10w600(),
                          )
                        ]),
                        TableRow(children: [
                          Text(
                            'Tanggal',
                            style: CustomTextStyle.black10w600(),
                          ),
                          Text(
                            ':',
                            style: CustomTextStyle.black10w600(),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            DateFormat('dd MMMM yyyy', 'id_ID').format(
                              DateTime.now(),
                            ),
                            style: CustomTextStyle.black10w600(),
                          )
                        ]),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildTTd()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTable() {
    final selectedSurahs = controller.getPickedSurahs();

    bool isTwoColumn = false;
    int no = 0;

    if (selectedSurahs.length > 19) {
      isTwoColumn = true;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(32),
              2: FixedColumnWidth(50)
            },
            border: TableBorder.all(),
            children: [
              TableRow(children: [
                _buildTableRowItem(value: 'No', padding: 4),
                _buildTableRowItem(value: 'Nama Surah', padding: 4),
                _buildTableRowItem(value: 'Predikat', padding: 4),
              ]),
              ...selectedSurahs
                  .take(selectedSurahs.length > 19
                      ? selectedSurahs.length ~/ 2
                      : selectedSurahs.length)
                  .map((e) {
                no += 1;

                return TableRow(children: [
                  _buildTableRowItem(value: no.toString(), padding: 4),
                  _buildTableRowItem(value: e['nama'], padding: 4),
                  _buildTableRowItem(
                      value: controller.getScores(surahName: e['nama']),
                      padding: 4),
                ]);
              })
            ],
          ),
        ),
        Visibility(
          visible: isTwoColumn,
          child: const SizedBox(width: 16),
        ),
        Visibility(
          visible: isTwoColumn,
          child: Expanded(
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(32),
                2: FixedColumnWidth(50)
              },
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  _buildTableRowItem(value: 'No', padding: 4),
                  _buildTableRowItem(value: 'Nama Surah', padding: 4),
                  _buildTableRowItem(value: 'Predikat', padding: 4),
                ]),
                ...selectedSurahs.sublist(selectedSurahs.length ~/ 2).map((e) {
                  no += 1;

                  return TableRow(children: [
                    _buildTableRowItem(value: no.toString(), padding: 4),
                    _buildTableRowItem(value: no.toString(), padding: 4),
                    _buildTableRowItem(value: no.toString(), padding: 4),
                  ]);
                })
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTableRowItem({required String value, double? padding}) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 0),
      child: Text(
        value,
        style: CustomTextStyle.black10w600(),
      ),
    );
  }

  Widget _buildRowItem(
      {required List<String> labels, required List<String> values}) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(66),
              1: FixedColumnWidth(12),
            },
            children: [
              TableRow(
                children: [
                  Text(
                    labels[0],
                    style: CustomTextStyle.black10w600(),
                  ),
                  Text(
                    ':',
                    style: CustomTextStyle.black10w600(height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    values[0],
                    style: CustomTextStyle.black10w600(),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 2,
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(66),
              1: FixedColumnWidth(12),
            },
            children: [
              TableRow(
                children: [
                  Text(
                    labels.last,
                    style: CustomTextStyle.black10w600(),
                  ),
                  Text(
                    ':',
                    style: CustomTextStyle.black10w600(),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    values.last,
                    style: CustomTextStyle.black10w600(),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTTd() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              'Orang tua / wali',
              style: CustomTextStyle.black11w400(),
            ),
            const SizedBox(height: 72),
            Container(
              width: 112,
              height: 1,
              color: Colors.black,
            )
          ],
        ),
        Column(
          children: [
            Text(
              'Wali Kelas',
              style: CustomTextStyle.black11w400(),
            ),
            const SizedBox(height: 72),
            Text(
              'Khatimah, S.Ag',
              style: CustomTextStyle.black11w600(),
            )
          ],
        ),
        Column(
          children: [
            Text(
              'Kepala Sekolah',
              style: CustomTextStyle.black11w400(),
            ),
            const SizedBox(height: 72),
            Text(
              'Khatimah, S.Ag',
              style: CustomTextStyle.black11w600(),
            )
          ],
        ),
      ],
    );
  }

  _buildPdf() async {
    final logo = await rootBundle.load('assets/logo_skl.png');
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) => _buildPwReport(logo),
    ));

    try {
      final status = await Permission.storage.request();

      if (status.isGranted) {
        Directory? directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }

        String? appDocPath = directory?.path;

        log(appDocPath!);
        final file = File('$appDocPath/${controller.student['fullName']}.pdf');
        await file.writeAsBytes(await pdf.save());
        Utils.showGetSnackbar('Saved in $appDocPath', true);
      }
    } catch (e) {
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  pw.Widget _buildPwReport(ByteData logo) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Image(
              width: 80,
              height: 80,
              pw.MemoryImage(
                logo.buffer.asUint8List(),
              ),
            ),
            pw.SizedBox(width: 16),
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Text(
                    'YAYASAN PP DARUSSALAM SAMPIT',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'MIS TAHFIDZ DARUSSALAM',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    'NSM: 111262020030 / NPSN: 70026175',
                    style: pw.TextStyle(
                        fontSize: 8, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    'Jalan Ir.Soekarno No. 142 RT.41, RW.14, Desa Sawahan',
                    style: pw.TextStyle(
                        fontSize: 8, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    'Kec. MB Ketapang Kab. Kotawaringin Timur Prov. Kalimantan Tengah',
                    style: pw.TextStyle(
                        fontSize: 8, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.RichText(
                    text: pw.TextSpan(
                        style: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.bold),
                        children: const [
                          pw.TextSpan(
                            text: 'Email: ',
                          ),
                          pw.TextSpan(
                            text: 'mitahfidzdarussalamspt@gmail.com',
                            style: pw.TextStyle(
                                color: PdfColors.blue,
                                decoration: pw.TextDecoration.underline),
                          ),
                          pw.TextSpan(
                            text: ' / No. HP: 0895338582715',
                          ),
                        ]),
                  )
                ],
              ),
            )
          ],
        ),
        pw.Divider(
          thickness: 4,
          color: PdfColors.black,
        ),
        pw.SizedBox(height: 24),
        pw.Text(
          'LAPORAN HASIL BELAJAR',
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          textAlign: pw.TextAlign.center,
        ),
        pw.SizedBox(height: 24),
        _buildPwRowItem(labels: [
          'Siswa',
          'Kelas'
        ], values: [
          controller.student['fullName'],
          controller.student['className']
        ]),
        _buildPwRowItem(labels: [
          'Induk / NISN',
          'Semester'
        ], values: [
          controller.student['studentNo'],
          controller.student['semester']
        ]),
        _buildPwRowItem(labels: [
          'Madrasah',
          'Tahun Pelajaran'
        ], values: [
          'MI Tahfidz Darussalam',
          '${DateTime.now().year - 1} / ${DateTime.now().year}'
        ]),
        pw.SizedBox(height: 32),
        _buildPwTable(),
        pw.Spacer(),
        pw.SizedBox(height: 16),
        pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.Row(
              children: [
                pw.Spacer(),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(children: [
                      pw.SizedBox(
                        width: 64,
                        child: pw.Text(
                          'Diberikan di',
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.SizedBox(
                        width: 8,
                        child: pw.Text(
                          ':',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Text(
                        'Sampit',
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold),
                      )
                    ]),
                    pw.Row(children: [
                      pw.SizedBox(
                        width: 64,
                        child: pw.Text(
                          'Tanggal',
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.SizedBox(
                        width: 8,
                        child: pw.Text(
                          ':',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Text(
                        DateFormat('dd MMMM yyyy', 'id_ID').format(
                          DateTime.now(),
                        ),
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold),
                      )
                    ]),
                  ],
                ),
              ],
            )),
        pw.SizedBox(height: 24),
        _buildPwTTd()
      ],
    );
  }

  pw.Widget _buildPwTable() {
    final selectedSurahs = controller.getPickedSurahs();

    bool isTwoColumn = false;
    int no = 0;

    if (selectedSurahs.length > 19) {
      isTwoColumn = true;
    }

    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Table(
            columnWidths: const {
              0: pw.FixedColumnWidth(32),
              2: pw.FixedColumnWidth(50)
            },
            border: pw.TableBorder.all(),
            children: [
              pw.TableRow(children: [
                _buildPwTableRowItem(value: 'No', padding: 4),
                _buildPwTableRowItem(value: 'Nama Surah', padding: 4),
                _buildPwTableRowItem(value: 'Predikat', padding: 4),
              ]),
              ...selectedSurahs
                  .take(selectedSurahs.length > 19
                      ? selectedSurahs.length ~/ 2
                      : selectedSurahs.length)
                  .map((e) {
                no += 1;

                return pw.TableRow(children: [
                  _buildPwTableRowItem(value: no.toString(), padding: 4),
                  _buildPwTableRowItem(value: e['nama'], padding: 4),
                  _buildPwTableRowItem(
                      value: controller.getScores(surahName: e['nama']),
                      padding: 4),
                ]);
              })
            ],
          ),
        ),
        pw.SizedBox(width: isTwoColumn ? 16 : 0),
        isTwoColumn
            ? pw.Expanded(
                child: pw.Table(
                  columnWidths: const {
                    0: pw.FixedColumnWidth(32),
                    2: pw.FixedColumnWidth(50)
                  },
                  border: pw.TableBorder.all(),
                  children: [
                    pw.TableRow(children: [
                      _buildPwTableRowItem(value: 'No', padding: 4),
                      _buildPwTableRowItem(value: 'Nama Surah', padding: 4),
                      _buildPwTableRowItem(value: 'Predikat', padding: 4),
                    ]),
                    ...selectedSurahs
                        .sublist(selectedSurahs.length ~/ 2)
                        .map((e) {
                      no += 1;

                      return pw.TableRow(children: [
                        _buildPwTableRowItem(value: no.toString(), padding: 4),
                        _buildPwTableRowItem(value: no.toString(), padding: 4),
                        _buildPwTableRowItem(value: no.toString(), padding: 4),
                      ]);
                    })
                  ],
                ),
              )
            : pw.SizedBox()
      ],
    );
  }

  pw.Widget _buildPwTableRowItem({required String value, double? padding}) {
    return pw.Padding(
      padding: pw.EdgeInsets.all(padding ?? 0),
      child: pw.Text(
        value,
        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  pw.Widget _buildPwRowItem(
      {required List<String> labels, required List<String> values}) {
    return pw.Row(
      children: [
        pw.Expanded(
          flex: 3,
          child: pw.Row(children: [
            pw.SizedBox(
              width: 80,
              child: pw.Text(
                labels.first,
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.SizedBox(
              width: 8,
              child: pw.Text(
                ':',
                textAlign: pw.TextAlign.center,
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Text(
              values.first,
              style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
            )
          ]),
        ),
        pw.SizedBox(width: 24),
        pw.Expanded(
          flex: 2,
          child: pw.Row(children: [
            pw.SizedBox(
              width: 80,
              child: pw.Text(
                labels.last,
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.SizedBox(
              width: 8,
              child: pw.Text(
                ':',
                textAlign: pw.TextAlign.center,
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Text(
              values.last,
              style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
            )
          ]),
        )
      ],
    );
  }

  pw.Widget _buildPwTTd() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          children: [
            pw.Text(
              'Orang tua / wali',
              style: const pw.TextStyle(fontSize: 11),
            ),
            pw.SizedBox(height: 72),
            pw.Container(
              width: 112,
              height: 1,
              color: PdfColors.black,
            )
          ],
        ),
        pw.Column(
          children: [
            pw.Text(
              'Wali Kelas',
              style: const pw.TextStyle(fontSize: 11),
            ),
            pw.SizedBox(height: 72),
            pw.Text(
              'Khatimah, S.Ag',
              style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
            )
          ],
        ),
        pw.Column(
          children: [
            pw.Text(
              'Kepala Sekolah',
              style: const pw.TextStyle(fontSize: 11),
            ),
            pw.SizedBox(height: 72),
            pw.Text(
              'Khatimah, S.Ag',
              style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
            )
          ],
        ),
      ],
    );
  }
}
