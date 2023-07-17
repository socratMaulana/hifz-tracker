import 'package:hifz_tracker_teacher/core_imports.dart';

import '../../controllers/update_profile_controller.dart';

class UpdateProfileScreen extends GetView<UpdateProfileController> {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.transparent(title: 'Update Profile'),
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
                      readOnly: true,
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
                  text: 'Update profile',
                  onPressed: () => controller.updateProfile(),
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
