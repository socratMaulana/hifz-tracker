import '../../../controllers/dashboard_controller.dart';
import '../../../core/widgets/image_network.dart';
import '../../../core_imports.dart';
import '../../chat_room/chat_room_binding.dart';
import '../../chat_room/chat_room_screen.dart';
import '../../new_chat/new_chat_bindng.dart';
import '../../new_chat/new_chat_screen.dart';

class ChatWidget extends GetView<DashboardController> {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getChats();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Obx(
          () => controller.isLoading.value
              ? const ShimmerListWidget()
              : controller.chats.isEmpty
                  ? const EmptyWidget()
                  : ListView.separated(
                      itemBuilder: (context, index) =>
                          _buildListItem(index: index),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                      itemCount: controller.chats.length),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => const NewChatScreen(),
            binding: NewChatBinding(), arguments: controller.students),
        label: Text(
          'Pesan Baru',
          style: CustomTextStyle.white(),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  InkWell _buildListItem({required int index}) {
    final chat = controller.chats[index];
    final student = chat['studentData'];
    final lastChat = chat['chats'].last;
    return InkWell(
      onTap: () => Get.to(
        () => const ChatRoomScreen(),
        binding: ChatRoomBinding(),
        arguments: student,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x14A1A1A1),
              spreadRadius: 1,
              blurRadius: 16,
              offset: Offset(0, 7), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            student['imageUrl'] == null
                ? Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: CustomColor.primaryColor,
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 16,
                    ))
                : CustomImageNetwork(
                    imageUrl: student['imageUrl'],
                    width: 48,
                    height: 48,
                    radius: 99,
                  ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${student['fullName']}',
                          style: CustomTextStyle.black14w700(),
                        ),
                      ),
                      Text(
                        Utils.formatDateFromMillis(
                            pattern: 'HH:mm', millis: lastChat['sendAt']),
                        style: lastChat['status'] == 'unread' &&
                                lastChat['sendBy'] != controller.userId
                            ? CustomTextStyle.black12w700()
                            : CustomTextStyle.grey12w400(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${lastChat['sendBy'] == controller.userId ? 'Anda:' : ''} ${lastChat['message']}',
                    style: lastChat['status'] == 'unread' &&
                            lastChat['sendBy'] != controller.userId
                        ? CustomTextStyle.black12w700()
                        : CustomTextStyle.grey12w400(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
