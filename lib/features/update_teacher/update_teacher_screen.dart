import 'package:hifz_tracker_teacher/core_imports.dart';

import '../../controllers/update_teacher_controller.dart';

class UpdateTeacherScreen extends GetView<UpdateTeacherController> {
  const UpdateTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.transparent(title: 'Update Guru'),
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
                      readOnly: true,
                    ),
                  ],
                ),
              ),
              Obx(
                () => CustomElevatedButton(
                  text: 'Update guru',
                  onPressed: () => controller.updateteacher(),
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
