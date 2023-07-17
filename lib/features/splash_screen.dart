import 'package:hifz_tracker_teacher/features/dashboard/dashboard_binding.dart';
import 'package:hifz_tracker_teacher/features/dashboard/dashboard_screen.dart';

import '../core_imports.dart';
import 'login/login_binding.dart';
import 'login/login_screen.dart';

class SplashScreen extends GetView<BaseController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final futures = Future.wait([controller.getCurrentLoggedInUser()]);

    Future.delayed(
      const Duration(seconds: 1),
      () async {
        final response = await futures;
        response.first.isNotEmpty
            ? Get.offAll(() => const DashboardScreen(),
                binding: DashboardBinding())
            : Get.offAll(() => const LoginScreen(), binding: LoginBinding());
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Image.asset(
            'assets/logo.png',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
