import 'package:hifz_tracker_teacher/core_imports.dart';

import '../../controllers/add_teacher_controller.dart';

class AddTeacherScreen extends GetView<AddTeacherController> {
  const AddTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.transparent(title: 'Tambah Guru'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.key,
          child: Column(
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
                      label: 'Username',
                      controller: controller.usernameCtr,
                      prefixIcon: Icons.abc,
                    ),
                    CustomLabeledTextFormField(
                      label: 'Email',
                      controller: controller.emailCtr,
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Icons.email,
                    ),
                    const Text('*note: Password default = hifzDefaultGuru')
                  ],
                ),
              ),
              Obx(
                () => CustomElevatedButton(
                  text: 'Tambah guru',
                  onPressed: () => controller.addteacher(),
                  borderRadius: 16,
                  isLoading: controller.isLoading.value,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
