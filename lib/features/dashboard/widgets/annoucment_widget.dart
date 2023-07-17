import 'package:get/get.dart';
import 'package:hifz_tracker_teacher/controllers/dashboard_controller.dart';

import '../../../core_imports.dart';

class AnnouncmentWidget extends GetView<DashboardController> {
  const AnnouncmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text(
          "Pengumuman",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )),
        Center(
            child: Text(
          "Cooming Soon",
          style: TextStyle(fontSize: 30),
        )),
        SizedBox(height: 20,),
        Center(child: Icon(Icons.assistant_photo, size: 50, color: Colors.green)),
      ],
    );
  }
}
