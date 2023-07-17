import '../../core_imports.dart';
import 'chat_room_controller.dart';

class ChatRoomScreen extends GetView<ChatRoomController> {
  const ChatRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.transparent(
        titleWidget: Obx(
          () => Text(controller.studentData['fullName'] ?? ''),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                child: controller.isLoading.value
                    ? const ShimmerListWidget()
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemCount: controller.chats.length,
                        itemBuilder: (context, index) =>
                            _buildListItem(context: context, index: index),
                      ),
                onRefresh: () => controller.getChats(),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(100),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: controller.messageCtr,
                    decoration: const InputDecoration(
                      hintText: 'Masukan pesan',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (value) =>
                        controller.showSendIcon(value.isNotEmpty),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.showSendIcon.value,
                    child: IconButton(
                      onPressed: () => controller.sendChat(),
                      icon: const Icon(
                        Icons.send,
                        color: CustomColor.primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem({required BuildContext context, required int index}) {
    final chat = controller.chats[index];

    return Column(
      children: [
        Visibility(
          visible: chat['showDate'],
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                const Expanded(
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    Utils.formatDateFromMillis(
                        pattern: 'dd MMMM yyyy', millis: chat['sendAt']),
                    style: CustomTextStyle.grey12w400(),
                  ),
                ),
                const Expanded(
                  child: Divider(),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: chat['sendBy'] == controller.userId
              ? Alignment.topRight
              : Alignment.topLeft,
          child: Container(
            width: MediaQuery.of(context).size.width / 2 - 16,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: chat['sendBy'] == controller.userId
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
              color: chat['sendBy'] == controller.userId
                  ? Colors.green.shade100
                  : Colors.grey.shade100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat['message'],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    Utils.formatDateFromMillis(
                        pattern: 'HH:mm', millis: chat['sendAt']),
                    style: CustomTextStyle.grey12w400(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
