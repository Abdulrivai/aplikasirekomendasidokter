import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatView'),
        centerTitle: true,
      ),
      body: Obx(
        () => DashChat(
          currentUser: controller.currentUser,
          onSend: controller.onSend,
          messages: controller.messages.value,
          typingUsers: controller.typingUsers.value,
          inputOptions: InputOptions(sendOnEnter: true),
          messageListOptions: MessageListOptions(
              chatFooterBuilder: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                // button akhiri chat
                controller.messages.isEmpty
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            controller.messages.clear();
                          },
                          child: const Text('Akhiri Chat'),
                        ),
                      ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
