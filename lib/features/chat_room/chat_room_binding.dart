import '../../core_imports.dart';
import 'chat_room_controller.dart';

class ChatRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatRoomController());
  }
}
