import 'package:hifz_tracker_teacher/core/widgets/custom_bottom_sheet.dart';
import 'package:hifz_tracker_teacher/core/widgets/labeled_dropdown.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';
import 'package:hifz_tracker_teacher/controllers/detail_student_controller.dart';
import 'package:hifz_tracker_teacher/features/add_history/add_history_binding.dart';
import 'package:hifz_tracker_teacher/features/add_history/add_history_screen.dart';
import 'package:hifz_tracker_teacher/features/report/report_screen.dart';

import '../report/report_binding.dart';

class DetailStudentScreen extends GetView<DetailStudentController> {
  const DetailStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.transparent(
          title: 'Riwayat ${controller.student['fullName']}',
          actions: [
            IconButton(
              onPressed: () => Get.to(() => const ReportScreen(),
                  binding: ReportBinding(),
                  arguments: controller.student['id']),
              icon: const Icon(Icons.print_outlined),
            )
          ]),
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(
          const Duration(seconds: 1),
          () => controller.getStudentHistory(),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextFormField(
                textEditingController: controller.selectedDateCtr,
                prefixIcon: const Icon(Icons.search),
                readOnly: true,
                onTap: () => _showDatePicker(context: context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 16),
              child: Obx(
                () => Row(
                  children: [
                    _buildChip(label: 'Hafal'),
                    const SizedBox(
                      width: 16,
                    ),
                    _buildChip(label: 'Kurang Lancar'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const ShimmerListWidget()
                    : controller.histories.isEmpty
                        ? ListView(
                            children: const [EmptyWidget()],
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: controller.histories.length,
                            itemBuilder: (context, index) =>
                                _buildListItem(index),
                          ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => const AddHistoryScreen(),
            binding: AddHistoryBinding(), arguments: controller.student['id']),
        label: const Text('Tambah Hafalan'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListItem(int index) {
    final history = controller.histories[index];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '(${history['type']}) ${history['surah']}',
                  style: CustomTextStyle.black16w700(),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ayat ${history['ayats'].join(', ')}',
                  style: CustomTextStyle.black(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Text(
                  '${Utils.formatDateFromMillis(pattern: 'MMM dd, HH:mm', millis: history['createdAt'])}'
                  ' WIB',
                  maxLines: 1,
                  style: CustomTextStyle.grey10w400(),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Text('Nilai'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: CustomColor.primaryColor,
                ),
                child: Text(
                  history['score'],
                  style: CustomTextStyle.white(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _showDatePicker({required BuildContext context}) async {
    final initialDate = DateFormat('dd MMMM yyyy', 'id_ID')
        .parse(controller.selectedDateCtr.text);
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1990),
        lastDate: DateTime.now());

    if (selectedDate != null) {
      final formattedDate =
          DateFormat('dd MMMM yyyy', 'id_ID').format(selectedDate);
      controller.selectedDateCtr.text = formattedDate;
      controller.getStudentHistory();
    }
  }

  ChoiceChip _buildChip({required String label}) {
    return ChoiceChip(
      label: Text(
        label,
        style: controller.selectedType.value == label
            ? CustomTextStyle.white()
            : CustomTextStyle.black(),
      ),
      selected: controller.selectedType.value == label,
      onSelected: (value) {
        controller.selectedType(label);
        controller.filterHistory();
      },
      selectedColor: CustomColor.primaryColor,
    );
  }
}
