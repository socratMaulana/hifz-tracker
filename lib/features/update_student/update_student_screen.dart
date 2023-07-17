import 'package:hifz_tracker_teacher/core_imports.dart';

import '../../controllers/update_student_controller.dart';

class UpdateStudentScreen extends GetView<UpdateStudentController> {
  const UpdateStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.transparent(title: 'Ubah Murid'),
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
                              readOnly: true,
                            ),
                            CustomLabeledTextFormField(
                              label: 'Nama Orang Tua',
                              controller: controller.parentNameCtr,
                              prefixIcon: Icons.person_2,
                            )
                          ],
                        ),
                      ),
                      Obx(
                        () => CustomElevatedButton(
                          text: 'Update murid',
                          onPressed: () => controller.updateStudent(),
                          borderRadius: 16,
                          isLoading: controller.isLoading.value,
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
