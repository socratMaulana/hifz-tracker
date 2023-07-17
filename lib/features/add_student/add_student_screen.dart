import 'package:hifz_tracker_teacher/core_imports.dart';
import 'package:hifz_tracker_teacher/controllers/add_student_controller.dart';

class AddStudentScreen extends GetView<AddStudentController> {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.transparent(title: 'Tambah Murid'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.key,
          child: Obx(
            () => controller.isLoading.value
                ? const ShimmerDetail()
                : Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            CustomLabeledTextFormField(
                              label: 'Nama Lengkap',
                              controller: controller.fullNameCtr,
                              prefixIcon: Icons.person,
                            ),
                            CustomLabeledTextFormField(
                              label: 'Nomor Murid',
                              controller: controller.studentNoCtr,
                              textInputType: TextInputType.number,
                              prefixIcon: Icons.numbers,
                            ),
                            CustomLabeledDropdown(
                              label: 'Kelas',
                              items: controller.classNames,
                              selectedValue: controller.selectedClass.value,
                              onSelect: (value) =>
                                  controller.selectedClass(value),
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.normal),
                              bgColor: Colors.white,
                              borderRadius: 8,
                            ),
                            const SizedBox(height: 12),
                            CustomLabeledDropdown(
                              label: 'Semester',
                              items: controller.semesters,
                              selectedValue: controller.selectedSemester.value,
                              onSelect: (value) =>
                                  controller.selectedSemester(value),
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.normal),
                              bgColor: Colors.white,
                              borderRadius: 8,
                            ),
                            const SizedBox(height: 12),
                            CustomLabeledTextFormField(
                              label: 'Email',
                              controller: controller.emailCtr,
                              textInputType: TextInputType.emailAddress,
                              prefixIcon: Icons.email,
                            ),
                            CustomLabeledTextFormField(
                              label: 'Nama Orang Tua',
                              controller: controller.parentNameCtr,
                              prefixIcon: Icons.person_2,
                            ),
                            const Text(
                                '*note: Password default = hifzDefaultMurid')
                          ],
                        ),
                      ),
                      CustomElevatedButton(
                        text: 'Tambah murid',
                        onPressed: () => controller.addStudent(),
                        borderRadius: 16,
                        isLoading: controller.isLoading.value,
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
