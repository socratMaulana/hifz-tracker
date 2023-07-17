import 'package:hifz_tracker_teacher/controllers/dashboard_controller.dart';
import 'package:hifz_tracker_teacher/core/widgets/custom_bottom_sheet.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';

class ClassWidget extends GetView<DashboardController> {
  const ClassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getClasses();
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Obx(
          () => controller.isLoading.value
              ? const ShimmerListWidget()
              : RefreshIndicator(
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        _buildListItem(context: context, index: index),
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.all(8),
                      child: Divider(),
                    ),
                    itemCount: controller.classes.length,
                  ),
                  onRefresh: () => controller.getClasses(),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showCustomBottomSheet(
          isDimissible: false,
          context: context,
          child: Column(
            children: [
              CustomTextFormField(
                textEditingController: controller.classCtr,
                labelText: 'Nama Kelas',
              ),
              const SizedBox(height: 32),
              Obx(
                () => CustomElevatedButton(
                  text: 'Simpan',
                  onPressed: () => controller.addClass(),
                  isLoading: controller.isBotSheetLoading.value,
                ),
              )
            ],
          ),
        ),
        label: const Text('Tambah Kelas'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  _showClassBottomSheet(
      {required BuildContext context, required dynamic clas}) {
    showCustomBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              Get.back();
              _showStudentBottomSheet(context: context, clas: clas);
            },
            child: const Text('List Murid'),
          ),
          const Divider(),
          TextButton(
            onPressed: () => controller.deleteClass(id: clas['id']),
            child: Text(
              'Hapus Kelas',
              style: CustomTextStyle.red(),
            ),
          ),
        ],
      ),
    );
  }

  _showStudentBottomSheet(
      {required BuildContext context, required dynamic clas}) {
    final masterStudents = controller.masterClassStudents
        .where((p0) => p0['classId'] == clas['id'])
        .toList();
    var students = masterStudents.obs;

    controller.classSearchCtr.clear();

    showCustomBottomSheet(
      context: context,
      child: Expanded(
        child: Obx(
          () => Column(
            children: [
              CustomTextFormField(
                textEditingController: controller.classSearchCtr,
                hintText: 'Masukan Nomor Murid',
                onChange: (value) {
                  if (controller.classSearchCtr.text.isNotEmpty) {
                    students(masterStudents
                        .where((p0) => p0['studentNo']
                            .contains(controller.classSearchCtr.text))
                        .toList());
                  } else {
                    students(masterStudents);
                  }
                },
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        students[index]['fullName'],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Nomor Murid: ${students[index]['studentNo']}',
                        style: CustomTextStyle.grey12w400(),
                      )
                    ],
                  ),
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.all(8),
                    child: Divider(),
                  ),
                  itemCount: students.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem({required BuildContext context, required int index}) {
    final clas = controller.classes[index];

    return InkWell(
      onTap: () => _showClassBottomSheet(context: context, clas: clas),
      child: Text(
        clas['className'],
        style: CustomTextStyle.black16w700(),
      ),
    );
  }
}
