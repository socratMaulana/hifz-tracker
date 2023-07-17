import 'package:hifz_tracker_teacher/controllers/dashboard_controller.dart';
import 'package:hifz_tracker_teacher/core/widgets/custom_bottom_sheet.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';
import 'package:hifz_tracker_teacher/features/detail_student/detail_student_binding.dart';
import 'package:hifz_tracker_teacher/features/detail_student/detail_student_screen.dart';
import 'package:hifz_tracker_teacher/features/update_student/update_student_screen.dart';

import '../../../core/widgets/image_network.dart';
import '../../surahs/surahs_screen.dart';
import '../../update_student/update_student_binding.dart';

class StudentsWidget extends GetView<DashboardController> {
  const StudentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getStudents();

    return RefreshIndicator(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomTextFormField(
              textEditingController: controller.searchCtr,
              hintText: 'Cari',
              prefixIcon: const Icon(Icons.search),
              onChange: (value) => controller.searchStudent(),
            ),
          ),
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const ShimmerListWidget()
                  : controller.students.isEmpty
                      ? ListView(
                          children: const [EmptyWidget()],
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: controller.students.length,
                          itemBuilder: (ctx, index) =>
                              _buildListItem(context: context, index: index),
                        ),
            ),
          )
        ],
      ),
      onRefresh: () => Future.delayed(
        const Duration(seconds: 1),
        () => controller.getStudents(),
      ),
    );
  }

  InkWell _buildListItem({required BuildContext context, required int index}) {
    final student = controller.students[index];

    return InkWell(
      onTap: () => _showOptionsBottomSheer(context: context, student: student),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 16),
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
        child: Row(
          children: [
            student['imageUrl'] == null
                ? Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: CustomColor.primaryColor,
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ))
                : CustomImageNetwork(
                    imageUrl: student['imageUrl'],
                    width: 56,
                    height: 56,
                    radius: 99,
                  ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${student['fullName']}',
                  style: CustomTextStyle.black16w700(),
                ),
                const SizedBox(height: 2),
                Text(
                  'Nomor murid: ${student['studentNo']}',
                  style: CustomTextStyle.grey12w400(),
                ),
                const SizedBox(height: 4),
                Text(
                  'Putra/i dari ${student['parentName']}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showOptionsBottomSheer(
      {required BuildContext context, required Map<String, dynamic> student}) {
    showCustomBottomSheet(
      context: context,
      child: Column(
        children: [
          Text(
            '${student['fullName']}',
            style: CustomTextStyle.black16w700(),
          ),
          const SizedBox(height: 4),
          const Text('Silahkan pilih menu dibawah:'),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Get.to(() => const DetailStudentScreen(),
                binding: DetailStudentBinding(), arguments: student),
            child: const Text('Lihat Detail'),
          ),
          TextButton(
            onPressed: () => Get.to(
                () => SurahsScreen(
                      studentId: student['id'],
                    ),
                arguments: student),
            child: const Text('Hafalan Surah'),
          ),
          const Divider(),
          TextButton(
            onPressed: () => Get.to(() => const UpdateStudentScreen(),
                binding: UpdateStudentBinding(), arguments: student),
            child: const Text('Ubah'),
          ),
          const Divider(),
          TextButton(
            onPressed: () =>
                _showDeleteDialog(context: context, id: student['id']),
            child: Text(
              'Hapus',
              style: CustomTextStyle.red(),
            ),
          ),
        ],
      ),
    );
  }

  _showDeleteDialog({
    required BuildContext context,
    required String id,
  }) {
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text(
              'Apakah anda yakin?',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => controller.deleteStudent(id),
              child: const Text('Ya'),
            ),
            const Divider(),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Tidak',
                style: CustomTextStyle.red(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
