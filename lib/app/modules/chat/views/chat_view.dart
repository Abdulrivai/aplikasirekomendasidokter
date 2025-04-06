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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/hmlogo.png', height: 32),
            const SizedBox(width: 8),
            const Text(
              'Healtmate',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Column(
          children: [
            // Banner dengan gambar URL hanya muncul jika messages kosong
            if (controller.messages.isEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/bank-sampah-1ef03.appspot.com/o/caridokter%2Fbekgroundhealt.png?alt=media&token=3d2d1d98-0af3-4bd5-a734-3ef4cecca284', // Ganti dengan URL gambar Anda
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: Text(
                            'Gagal memuat gambar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            Expanded(
              child: DashChat(
                currentUser: controller.currentUser,
                onSend: controller.onSend,
                messages: controller.messages,
                typingUsers: controller.typingUsers,
                inputOptions: const InputOptions(
                  sendOnEnter: true,
                  inputDecoration: InputDecoration.collapsed(hintText: ''),
                ),
                messageListOptions: const MessageListOptions(),
                messageOptions: MessageOptions(
                  currentUserContainerColor:
                      const Color.fromARGB(255, 0, 140, 255),
                  currentUserTextColor:
                      const Color.fromARGB(255, 255, 255, 255),
                  containerColor: Colors.grey.shade300,
                  textColor: Colors.black,
                ),
              ),
            ),
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tombol pintasan dan Akhiri Chat dalam scroll horizontal
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Tombol Akhiri Chat (hanya muncul saat ada pesan)
                        if (controller.messages.isNotEmpty)
                          ElevatedButton(
                            onPressed: () {
                              controller.messages.clear();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.shade400,
                                    Colors.blue.shade800
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 24),
                              child: const Center(
                                child: Text(
                                  'Akhiri Chat',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (controller.messages.isNotEmpty)
                          const SizedBox(width: 10),
                        // Tombol pintasan (selalu muncul)
                        _buildQuickButton(context,
                            'Saya Ada berapa Keluhan Terutama Sakit Kepala'),
                        const SizedBox(width: 8),
                        _buildQuickButton(context, 'Saya butuh bantuan'),
                        const SizedBox(width: 8),
                        _buildQuickButton(context, 'Saya ingin booking dokter'),
                        const SizedBox(width: 8),
                        _buildQuickButton(context,
                            'berikan saya jadwal dokter yang tersedia'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.textController,
                          decoration: InputDecoration(
                            hintText: 'Tulis pesan Anda...',
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.blue.shade200, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.blue.shade400, width: 2),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              controller.onSend(ChatMessage(
                                text: value,
                                user: controller.currentUser,
                                createdAt: DateTime.now(),
                              ));
                              controller.textController.clear();
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          if (controller.textController.text.isNotEmpty) {
                            controller.onSend(ChatMessage(
                              text: controller.textController.text,
                              user: controller.currentUser,
                              createdAt: DateTime.now(),
                            ));
                            controller.textController.clear();
                          }
                        },
                        icon: Icon(Icons.send, color: Colors.blue.shade400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun tombol pintasan
  Widget _buildQuickButton(BuildContext context, String message) {
    return ElevatedButton(
      onPressed: () {
        controller.onSend(ChatMessage(
          text: message,
          user: controller.currentUser,
          createdAt: DateTime.now(),
        ));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Warna latar belakang putih
        foregroundColor: Colors.blue.shade400, // Warna teks biru
        side: BorderSide(
            color: Colors.blue.shade400, width: 1.5), // Garis tepi biru
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Sudut bulat
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
