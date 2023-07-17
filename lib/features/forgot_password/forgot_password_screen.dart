import 'package:hifz_tracker_teacher/controllers/forgot_password_controller.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordControler> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.transparent(),
      body: SafeArea(
        child: Form(
          key: controller.key,
          child: ListView(
            children: [
              Image.asset(
                'assets/forgot_password.png',
                height: 184,
                width: double.infinity,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Lupa password',
                  style: CustomTextStyle.black5424w700(),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: CustomTextFormField(
                  textEditingController: controller.emailCtr,
                  hintText: 'Masukan email anda',
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Obx(
                  () => CustomElevatedButton(
                    text: 'Kirim',
                    onPressed: () => controller.sendResetPasswordEmail(),
                    borderRadius: 8,
                    isLoading: controller.isLoading.value,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
