import '../../core_imports.dart';
import 'new_chat_controller.dart';

class NewChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewChatController());
  }
}
