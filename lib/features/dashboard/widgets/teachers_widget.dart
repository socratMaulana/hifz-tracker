import 'package:hifz_tracker_teacher/controllers/dashboard_controller.dart';
import 'package:hifz_tracker_teacher/core/widgets/custom_bottom_sheet.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';
import 'package:hifz_tracker_teacher/features/update_teacher/update_teacher_binding.dart';
import 'package:hifz_tracker_teacher/features/update_teacher/update_teacher_screen.dart';

import '../../../core/widgets/image_network.dart';

class TeachersWidget extends GetView<DashboardController> {
  const TeachersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getTeachers();

    return RefreshIndicator(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomTextFormField(
              textEditingController: controller.searchCtr,
              hintText: 'Cari',
              prefixIcon: const Icon(Icons.search),
              onChange: (value) => controller.searchTeacher(),
            ),
          ),
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const ShimmerListWidget()
                  : controller.teachers.isEmpty
                      ? ListView(
                          children: const [EmptyWidget()],
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: controller.teachers.length,
                          itemBuilder: (ctx, index) =>
                              _buildListItem(context: context, index: index),
                        ),
            ),
          )
        ],
      ),
      onRefresh: () => Future.delayed(
        const Duration(seconds: 1),
        () => controller.getTeachers(),
      ),
    );
  }

  InkWell _buildListItem({required BuildContext context, required int index}) {
    final teacher = controller.teachers[index];

    return InkWell(
      onTap: () => _showOptionsBottomSheer(context: context, teacher: teacher),
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
            teacher['imageUrl'] == null
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
                    imageUrl: teacher['imageUrl'],
                    width: 56,
                    height: 56,
                    radius: 99,
                  ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${teacher['fullName']}',
                  style: CustomTextStyle.black16w700(),
                ),
                const SizedBox(height: 2),
                Text(
                  'Username: ${teacher['username']}',
                  style: CustomTextStyle.grey12w400(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showOptionsBottomSheer(
      {required BuildContext context, required Map<String, dynamic> teacher}) {
    showCustomBottomSheet(
      context: context,
      child: Column(
        children: [
          Text(
            '${teacher['fullName']}',
            style: CustomTextStyle.black16w700(),
          ),
          const SizedBox(height: 4),
          const Text('Silahkan pilih menu dibawah:'),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Get.to(() => const UpdateTeacherScreen(),
                binding: UpdateTeacherBinding(), arguments: teacher),
            child: const Text('Ubah'),
          ),
          const Divider(),
          TextButton(
            onPressed: () => controller.deleteTeacher(teacher['id']),
            child: Text(
              'Hapus',
              style: CustomTextStyle.red(),
            ),
          ),
        ],
      ),
    );
  }
}
