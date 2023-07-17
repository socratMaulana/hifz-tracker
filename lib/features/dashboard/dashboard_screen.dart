import 'package:hifz_tracker_teacher/core_imports.dart';
import 'package:hifz_tracker_teacher/controllers/dashboard_controller.dart';
import 'package:hifz_tracker_teacher/features/add_student/add_student_binding.dart';
import 'package:hifz_tracker_teacher/features/add_student/add_student_screen.dart';
import 'package:hifz_tracker_teacher/features/add_teacher/add_teacher_screen.dart';

import '../add_teacher/add_teacher_binding.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.transparent(
        titleWidget: Obx(
          () => Text(controller.currentTitle.value),
        ),
      ),
      body: Obx(() => controller.currentWidget.value),
      floatingActionButton: _buildFab(),
      bottomNavigationBar: _buildBotnav(),
    );
  }

  Obx _buildFab() {
    return Obx(
      () => Visibility(
        visible: controller.currentIndex.value == 1 ||
            (controller.currentIndex.value == 3),
        child: FloatingActionButton.extended(
          onPressed: controller.currentIndex.value == 1
              ? () => Get.to(
                    () => const AddStudentScreen(),
                    binding: AddStudentBinding(),
                  )
              : () => Get.to(
                    () => const AddTeacherScreen(),
                    binding: AddTeacherBinding(),
                  ),
          label: Text(controller.currentIndex.value == 1
              ? 'Tambah Murid'
              : 'Tambah Guru'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }

  Obx _buildBotnav() {
    return Obx(
      () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: controller.currentIndex.value,
          onTap: (value) => controller.setCurrentIndex(value),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_4_outlined), label: 'Murid'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: 'Guru'),
            BottomNavigationBarItem(
                icon: Icon(Icons.class_outlined), label: 'Kelas'),
            BottomNavigationBarItem(
                icon: Icon(Icons.assistant_photo), label: 'Pengumuman'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: 'Profile'),

          ]),
    );
  }
}
