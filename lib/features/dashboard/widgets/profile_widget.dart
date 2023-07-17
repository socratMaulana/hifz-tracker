import 'package:hifz_tracker_teacher/controllers/dashboard_controller.dart';
import 'package:hifz_tracker_teacher/core/widgets/custom_bottom_sheet.dart';
import 'package:hifz_tracker_teacher/core/widgets/image_network.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';
import 'package:hifz_tracker_teacher/features/update_profile/update_profile_binding.dart';
import 'package:hifz_tracker_teacher/features/update_profile/update_profile_screen.dart';

class ProfileWidget extends GetView<DashboardController> {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const ShimmerDetail()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                InkWell(
                  onTap: () => controller.changeImage(),
                  child: Stack(
                    children: [
                      controller.userController.loggedInUser['imageUrl'] == null
                          ? Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                  color: CustomColor.primaryColor,
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 48,
                              ))
                          : CustomImageNetwork(
                              imageUrl: controller
                                  .userController.loggedInUser['imageUrl'],
                              width: 80,
                              height: 80,
                              radius: 99,
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow()]),
                          child: const Icon(
                            Icons.photo_camera_outlined,
                            color: CustomColor.primaryColor,
                            size: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.userController.loggedInUser['fullName'],
                  style: CustomTextStyle.black16w400(),
                ),
                const SizedBox(height: 32),
                InkWell(
                  onTap: () => Get.to(() => const UpdateProfileScreen(),
                      binding: UpdateProfileBinding()),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.edit,
                          color: CustomColor.primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text('Ubah Profile')
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => _showUpdateEmail(context: context),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.email_outlined,
                          color: CustomColor.primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text('Ubah Email')
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => _showUpdatePassword(context: context),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.password_outlined,
                          color: CustomColor.primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text('Ubah Password')
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => controller.logout(),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Keluar',
                          style: CustomTextStyle.red(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  _showUpdatePassword({required BuildContext context}) {
    controller.updatePasswordCtr.clear();
    controller.updatePasswordConfirmCtr.clear();
    controller.updatePasswordOldCtr.clear();

    showCustomBottomSheet(
        context: context,
        child: Form(
          key: controller.updatePasswordKey,
          child: Expanded(
            child: ListView(
              children: [
                Text(
                  'Ubah password',
                  style: CustomTextStyle.black14w700(),
                ),
                const SizedBox(height: 32),
                CustomTextFormField(
                  textEditingController: controller.updatePasswordOldCtr,
                  hintText: 'Masukan password saat ini',
                  obscureText: true,
                ),
                CustomTextFormField(
                  textEditingController: controller.updatePasswordCtr,
                  hintText: 'Masukan password baru',
                  obscureText: true,
                ),
                CustomTextFormField(
                  textEditingController: controller.updatePasswordConfirmCtr,
                  hintText: 'Konfirmasi password baru',
                  obscureText: true,
                ),
                const SizedBox(height: 32),
                Obx(
                  () => CustomElevatedButton(
                    text: 'Ubah password',
                    onPressed: () => controller.updatePassword(),
                    isLoading: controller.updatePasswordLoading.value,
                    borderRadius: 16,
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _showUpdateEmail({required BuildContext context}) {
    controller.updateEmailCtr.clear();
    controller.updateEmailPasswordCtr.clear();

    showCustomBottomSheet(
        context: context,
        child: Form(
          key: controller.updateEmailKey,
          child: Expanded(
            child: ListView(
              children: [
                Text(
                  'Ubah Email',
                  style: CustomTextStyle.black14w700(),
                ),
                const SizedBox(height: 32),
                CustomTextFormField(
                  textEditingController: controller.updateEmailPasswordCtr,
                  hintText: 'Masukan password saat ini',
                  obscureText: true,
                ),
                CustomTextFormField(
                  textEditingController: controller.updateEmailCtr,
                  hintText: 'Masukan Email baru',
                ),
                const SizedBox(height: 32),
                Obx(
                  () => CustomElevatedButton(
                    text: 'Ubah Email',
                    onPressed: () => controller.updateEmail(),
                    isLoading: controller.updateEmailLoading.value,
                    borderRadius: 16,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
