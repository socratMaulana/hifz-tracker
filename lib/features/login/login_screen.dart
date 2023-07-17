import 'package:hifz_tracker_teacher/controllers/login_controller.dart';
import 'package:hifz_tracker_teacher/features/forgot_password/forgot_password_binding.dart';
import 'package:hifz_tracker_teacher/features/forgot_password/forgot_password_screen.dart';
import '../../core_imports.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

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
                'assets/login.png',
                height: 184,
                width: double.infinity,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Masuk',
                  style: CustomTextStyle.black5424w700(),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextFormField(
                  textEditingController: controller.usernameCtr,
                  hintText: 'Username',
                  prefixIcon: const Icon(Icons.fingerprint),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextFormField(
                  textEditingController: controller.passwordCtr,
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  obscureText: true,
                  maxLines: 1,
                ),
              ),
              UnconstrainedBox(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: InkWell(
                    onTap: () => Get.to(() => const ForgotPasswordScreen(),
                        binding: ForgotPasswordBinding()),
                    child: Text(
                      'Lupa password',
                      style: CustomTextStyle.primary(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Obx(
                  () => CustomElevatedButton(
                    text: 'Masuk',
                    onPressed: () => controller.login(),
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
